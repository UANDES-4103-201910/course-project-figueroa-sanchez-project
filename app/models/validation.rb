class Validation < ApplicationRecord
  belongs_to :post
  belongs_to :user
  validate :vote_type
  validates_uniqueness_of :post_id, :scope => [:user_id]

  def vote_type
    if vote != 1 && vote != -1
      errors.add(:vote, "Must be 1 or -1")
    end
  end

  def get_voted_posts
    validations = Validation.where(user_id: user)
    up_posts = Array.new
    down_posts = Array.new
    posts = Hash.new
    if validations
      profile = Profile.where(user_id: user).first
      validations.each do |validation|
        post = Post.where(id:validation.post_id).first
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
          if validation.vote > 0
            up_posts << n_post
          else
            down_posts << n_post
          end
        end
      end
    end
    posts['up'] = up_posts
    posts['down'] = down_posts
    posts
  end
end
