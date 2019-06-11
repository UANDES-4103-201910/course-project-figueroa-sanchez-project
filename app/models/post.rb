class Post < ApplicationRecord
  has_many_attached :images
  has_many_attached :files
  has_one :dumpster
  belongs_to :user
  has_many :reports
  has_many :comments
  has_many :validations
  has_many :shared_posts
  has_many :follow_posts
  has_one :post_location, inverse_of: :post
  validates :title, presence: true, length: { maximum: 50 }
  accepts_nested_attributes_for :post_location

  def self.get_posts_ordered_by_votes
    posts_with_validations = Validation.group(:post_id).count
    posts_ordered_by_votes = Array.new
    posts_with_validations.keys.sort_by { |key| posts_with_validations[key] }.each do
    |key|
      posts_ordered_by_votes << Post.find(key)
    end
    posts_ordered_by_votes.reverse
    posts_ordered_by_votes
  end

  def is_inappropriate?
    report_count = Report.where("created_at < ? AND post_id = ?",7.days.ago,id).length
    if report_count>=3
      true
    else
      false
    end
  end

  def is_in_dumpster?
    if Dumpster.where(post_id: id).length>0
      true
    else
      false
    end
  end

  def self.get_post_by_word(keyword)
    posts = Array.new
    all_posts = Post.all
    posts_by_title = all_posts.where("title LIKE ?", "%#{keyword}%")
    posts_by_description = all_posts.where("description LIKE ?", "%#{keyword}%")
    if posts_by_title
      posts_by_title.each do |post|
        profile = Profile.where(user_id: post.user_id).first
        n_post = Hash.new
        n_post["id"] = post.id
        n_post["title"] = post.title
        n_post["description"] = post.description
        n_post["date"] = post.created_at
        n_post["author_name"] = profile.first_name + " " + profile.last_name
        n_post["author_id"] = post.user_id
        n_post["author_image"] = Profile.find_by_user_id(n_post['author_id']).image
        n_post["votes"] = post.get_votes
        unless Post.find(n_post['id']).is_in_dumpster?
          posts << n_post
        end
      end
    end
    if posts_by_description
      posts_by_description.each do |post|
        profile = Profile.where(user_id: post.user_id).first
        n_post = Hash.new
        n_post["id"] = post.id
        n_post["title"] = post.title
        n_post["description"] = post.description
        n_post["date"] = post.created_at
        n_post["author_name"] = profile.first_name + " " + profile.last_name
        n_post["author_id"] = post.user_id
        n_post["author_image"] = Profile.find_by_user_id(n_post['author_id']).image
        n_post["votes"] = post.get_votes
        unless Post.find(n_post['id']).is_in_dumpster?
          posts << n_post
        end
      end
    end
    posts = posts & posts
    posts
  end

  def self.get_post_by_author(keyword)
    posts = Array.new
    all_profiles = Profile.all
    first_name_profile = all_profiles.where("first_name LIKE ?", "%#{keyword}%")
    last_name_profile = all_profiles.where("first_name LIKE ?", "%#{keyword}%")
    profiles = Array.new

    if first_name_profile
      first_name_profile.each do |profile|
        profiles << profile.user_id
      end
    end

    if last_name_profile
      last_name_profile.each do |profile|
        profiles << profile.user_id
      end
    end

    if profiles.length > 0
      profiles = profiles & profiles
      profiles.each do |id|
        a_posts = Post.where(user_id: id)
        a_posts.each do |post|
          profile = Profile.where(user_id: post.user_id).first
          n_post = Hash.new
          n_post["id"] = post.id
          n_post["title"] = post.title
          n_post["description"] = post.description
          n_post["date"] = post.created_at
          n_post["author_name"] = profile.first_name + " " + profile.last_name
          n_post["author_id"] = post.user_id
          n_post["author_image"] = Profile.find_by_user_id(n_post['author_id']).image
          n_post["votes"] = post.get_votes
          unless Post.find(n_post['id']).is_in_dumpster?
            posts << n_post
          end
        end
      end
    end
    posts.uniq
    posts
  end

  def self.get_posts_votes
    posts = Post.all
    validations = Validation.group(:post_id).sum(:vote)
    posts_by_validation = Hash.new
    posts.each do |post|
      if validations[post.id] != nil
        posts_by_validation[post.id] = validations[post.id]
      else
        posts_by_validation[post.id] = 0
      end
    end
    posts_by_validation
  end

  def author
     author = User.find(user_id).email
  end

  def get_votes
    votes = Validation.where(post_id: id).group(:vote).count
    votes_hash = Hash.new
    votes_hash["up"] = votes[1]
    votes_hash["down"] = votes[-1]
    if votes_hash["up"].nil?
      votes_hash["up"] = 0
    end
    if votes_hash["down"].nil?
      votes_hash["down"] = 0
    end
    votes_hash
  end

  def get_post_attachments
    post_attachments_items = Post.where(post_id: id).images
    categories = Category.all
    attachments = Hash.new
    categories.each do |item|
      attachments[item.name] = ''
    end
    post_attachments_items.each do |item|
      attachments[Category.find(item.category_id).name] = item.link
    end
    attachments
  end

  def count_reports
    reports_count = Report.where(post_id: id).count
  end

  def get_reports
    reports_raw = Report.where(post_id: id)
    reports = Array.new
    reports_raw.each do |report|
      report_d = Hash.new
      report_d["category"] = ReportCategory.find(report.report_category_id).name
      report_d["author"] = User.find(report.user_id).email
      report_d["comment"] = report.comment
    end
  end

  def get_user_mail
    user_mail = User.find(user_id).email
  end

  def get_user_photo
    user = User.find(user_id)
    user.get_actual_photo
  end

  def self.get_post(id)
    post = Post.find(id)
    post_info=Hash.new
    post_info["id"] = post.id
    post_info["title"] = post.title
    post_info["description"] = post.description
    post_info["solved"] = post.solved
    post_info["date"] = post.created_at.to_date
    post_info["user_id"] = post.user_id
    user_profile = Profile.find_by_user_id(post.user_id)
    post_info["user_first_name"] = user_profile.first_name
    post_info["user_last_name"] = user_profile.last_name
    post_info["user_image"] =  user_profile.image
    post_info['votes'] = post.get_votes
    post_info['images'] = post.images
    post_info['files'] = post.files
    post_info
  end

  def self.get_comments(id)
    comments_raw = Comments.where(post_id: id).order(created_at: :asc)
    comments = Array.new
    comments_raw.each do |item|
      comment = Hash.new
      comment["id"] = item.id
      comment["user_id"] = item.user_id
      comment["user_first_name"] = Profile.find(item.user_id).first_name
      comment["user_last_name"] = Profile.find(item.user_id).last_name
      comment["text"] = item.comment
      comment["date"] = item.created_at
      comments << comment
    end
    comments
  end

end
