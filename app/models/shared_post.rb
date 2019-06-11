class SharedPost < ApplicationRecord
  belongs_to :post
  belongs_to :user

  def get_shared_posts
    s_posts = SharedPost.where(user_id: user)
    posts = Array.new
    if s_posts
      profile = Profile.where(user_id: user).first
      s_posts.each do |s_post|
        post = Post.where(id:s_post.post_id).first
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
    posts
  end
end
