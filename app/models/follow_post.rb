class FollowPost < ApplicationRecord
  belongs_to :post
  belongs_to :user

  def get_following_posts
    f_posts = FollowPost.where(user_id: user)
    posts = Array.new
    if f_posts
      profile = Profile.where(user_id: user).first
      f_posts.each do |f_post|
        post = Post.where(id:f_post.post_id).first
        n_post = Hash.new
        n_post["id"] = post.id
        n_post["title"] = post.title
        n_post["description"] = post.description
        n_post["date"] = post.created_at
        n_post["author_name"] = profile.first_name + " " + profile.last_name
        n_post["author_id"] = post.user_id
        n_post["author_image"] = Profile.find_by_user_id(n_post['author_id']).image
        n_post["votes"] = post.get_votes
        posts << n_post
      end
    end
    posts
  end
end
