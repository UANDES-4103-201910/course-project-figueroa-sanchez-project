class Post < ApplicationRecord
  has_many :attachments
  has_one :dumpster
  belongs_to :user
  has_many :reports
  has_many :comments
  has_many :validations
  has_many :shared_posts
  validates :title, presence: true, length: { maximum: 50 }

  def self.get_posts_ordered_by_votes
    posts_with_validations = Validation.group(:post_id).count
    @posts_ordered_by_votes = Array.new
    posts_with_validations.keys.sort_by { |key| posts_with_validations[key] }.each do
    |key|
      @posts_ordered_by_votes << Post.find(key)
    end
    @posts_ordered_by_votes.reverse
    @posts_ordered_by_votes
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

  def get_votes
    votes = Validation.where(post_id: id).group(:vote).count
    votes_hash = {"up": votes[1], "down":votes[-1]}
    votes_hash
  end

  def get_post_attachments
    post_attachments_items = Attachment.where(post_id: id)
    categories = Category.all
    attachments = Hash.new
    post_attachments_items.each do |item|
      attachments[Category.find(item.category_id).name] = item.link
    end
    attachments
  end

  def count_reports
    reports_count = Report.where(post_id: id).count
  end

  def get_reports
    reports = Report.where(post_id: id)
  end

  def get_user_photo
    user = User.find(user_id)
    user.get_actual_photo
  end
end

#Post.get_posts_ordered_by_votes