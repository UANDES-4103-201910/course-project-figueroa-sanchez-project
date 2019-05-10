class HomeController < ApplicationController
  def home
    all_posts = Post.get_posts_ordered_by_votes
    top_20_posts_raw = all_posts[5..20]
    top_5_posts_raw = all_posts[0..4]
    @top_20_post = Array.new
    @top_5_post = Array.new
    #top_20_posts_raw.each do |post|
    #  @top_20_post << Post.get_post(post.id)
    #end

    #top_5_posts_raw.each do |post|
    #  @top_5_post << Post.get_post(post.id)
    #end

    @top_20_post
    @top_5_post
  end
end
