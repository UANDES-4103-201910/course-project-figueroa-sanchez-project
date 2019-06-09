class UserListController < ApplicationController
  before_action :authenticate_user!
  def index
    users = User.all
    @users_info = Array.new
    users.each do |user|
      profile = Profile.find_by_user_id(user.id)
      role = user.get_role
      if profile && role
        user_info = Hash.new
        user_info["id"] = user.id
        user_info["email"] = user.email
        user_info["is_active"] = user.is_active
        user_info["first_name"] = profile.first_name
        user_info["last_name"] = profile.last_name
        user_info["last_access"] = user.last_sign_in_at
        user_info["role"] = role
        @users_info << user_info
      end
    end
    @users_info
  end
end
