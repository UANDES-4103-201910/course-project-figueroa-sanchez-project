class AdminHomeController < ApplicationController
  def index
    posts = Post.all.order(created_at: :desc)
    @post_list = Array.new

    posts.each do |post|
      item = Hash.new
      item["post"] = post
      item["author"] = User.find(post.user_id).mail
      @post_list << item
    end
  end
end
