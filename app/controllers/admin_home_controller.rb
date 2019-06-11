class AdminHomeController < ApplicationController
  before_action :authenticate_user!

  def index
    posts = Post.all.order(created_at: :desc)
    @post_list = Array.new
    admin_locations = AdminLocation.where(user_id: current_user.id)
    posts.each do |post|
      if admin_locations.length >= 1
        post_location = PostLocation.find_by_post_id(post.id)
        if post_location
          if current_user.locations.include? Location.find(post_location.location_id)
            item = Hash.new
            item["post"] = post
            item["author"] = User.find(post.user_id).email
            @post_list << item
          end
        end
      else
        item = Hash.new
        item["post"] = post
        item["author"] = User.find(post.user_id).email
        @post_list << item
      end

    end
  end
end
