class UserListController < ApplicationController
  def index
    users = User.all
    profiles = Profile.all
    @users_info = Array.new
    users.each do |user|
      user_info = Hash.new
      user_info["id"] = user.id
      user_info["email"] = user.email
      user_info["is_active"] = user.is_active
      user_info["first_name"] = profiles.where(user_id:user.id).first.first_name
      user_info["last_name"] = profiles.where(user_id:user.id).first.last_name
      user_info["last_access"] = user.last_sign_in_at
      user_info["role"] = user.get_role
      @users_info << user_info
    end
    @users_info
  end
end
