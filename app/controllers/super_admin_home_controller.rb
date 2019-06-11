class SuperAdminHomeController < ApplicationController
  before_action :authenticate_user!
  def index
    posts = Post.all.order(created_at: :desc)
    @post_list = Array.new
    posts.each do |post|
      item = Hash.new
      item["post"] = post
      item["author"] = User.find(post.user_id).email
      @post_list << item
    end
  end
end
