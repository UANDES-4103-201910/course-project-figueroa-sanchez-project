class HomeController < ApplicationController
  before_action :check_profile
  skip_before_action


  def home
    all_posts = Post.get_posts_ordered_by_votes
    follow_post_current_user = FollowPost.all
    top_20_posts_raw = all_posts[5..20]
    if all_posts.length == 0
      top_20_posts_raw = nil
    end

    @top_20_post = Array.new
    @following_posts = Array.new
    follow_post_first = follow_post_current_user.where(user_id: current_user.id).first
    if follow_post_first
      @following_posts = follow_post_first.get_following_posts
    end
    if top_20_posts_raw
      top_20_posts_raw.each do |post|
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
        @top_20_post << n_post
      end
    else
      @top_20_post = nil
    end
  end

end
