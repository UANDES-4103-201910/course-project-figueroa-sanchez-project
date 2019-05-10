class HomeController < ApplicationController
  def home
    all_posts = Post.get_posts_ordered_by_votes
    top_20_posts_raw = all_posts[5..20]
    top_5_posts_raw = all_posts[0..4]
    @top_20_post = Array.new
    @top_5_post = Array.new


    top_5_posts_raw.each do |post|
      profile = Profile.where(user_id: post.user_id).first
      n_post = Hash.new
      n_post["id"] = post.id
      n_post["title"] = post.title
      n_post["description"] = post.description
      n_post["date"] = post.created_at
      n_post["author_name"] = profile.first_name + " "+ profile.last_name
      n_post["author_id"] = post.user_id
      n_post["votes"] = post.get_votes
      @top_5_post << n_post
    end

    top_20_posts_raw.each do |post|
      profile = Profile.where(user_id: post.user_id).first
      n_post = Hash.new
      n_post["id"] = post.id
      n_post["title"] = post.title
      n_post["description"] = post.description
      n_post["date"] = post.created_at
      n_post["author_name"] = profile.first_name + " "+ profile.last_name
      n_post["author_id"] = post.user_id
      n_post["votes"] = post.get_votes
      @top_20_post << n_post
    end
    @top_20_post
    @top_5_post
  end
end
