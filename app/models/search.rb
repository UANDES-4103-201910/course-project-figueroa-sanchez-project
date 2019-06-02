class Search < ApplicationRecord
  belongs_to :user

  def posts
    @post ||= find_posts
  end

  private

  def find_posts
    posts = Post.all
    puts(posts[0])
    if location
      posts = posts.where("profile_location LIKE ? ","%#{keywords}") if keywords.present?
    else
      #posts = posts.where("user.id LIKE " + User.where(), "%#{keywords}") if keywords.present?
      profiles = Profile.where("first_name LIKE ? ", "#{keywords}") if keywords.present?
      users = []
      profiles.each do |profile|
        users.append(profile.user_id)
      end
      posts = posts.where("user LIKE ? ", users) if users.present?
    end
    posts
  end
end
