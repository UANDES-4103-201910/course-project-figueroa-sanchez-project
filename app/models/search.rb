class Search < ApplicationRecord
  belongs_to :user

  def posts
    @post ||= find_posts
  end

  private

  def find_posts
    posts = Post.order(:title)
    if location
      posts = posts.where("profile_location LIKE ? ","%#{keywords}") if keywords.present?
    else
      posts = posts.where("profile.first_name LIKE ? ", "%#{keywords}") if keywords.present?
    end
    posts
  end
end
