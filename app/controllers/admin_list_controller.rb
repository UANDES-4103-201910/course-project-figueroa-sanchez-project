class AdminListController < ApplicationController
  before_action :authenticate_user!
  def index
    users = UserRole.where(role_id:2)
    admins = Array.new
    users.each do |userole|
      admins << User.find(userole.user_id)
    end
    @users_info = Array.new
    admins.each do |user|
      user_info = Hash.new
      user_info["id"] = user.id
      user_info["email"] = user.email
      user_info["is_active"] = user.is_active
      user_info["geofences"] = user.get_geofences.join(", ")
      user_info["last_access"] = user.last_sign_in_at
      @users_info << user_info
    end
    @users_info
  end
end
