class HomeController < ApplicationController
  def home
    all_posts = Post.get_posts_ordered_by_votes
    @top_20_posts = all_posts[5..20]
    @top_5_posts = all_posts[0..4]
  end
end
