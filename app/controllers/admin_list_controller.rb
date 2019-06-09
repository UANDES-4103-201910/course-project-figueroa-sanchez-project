class AdminListController < ApplicationController
  before_action :authenticate_user!
  def index
    users = UserRole.where(role_id:2)
    admins = Array.new
    users.each do |userole|
      admins << User.find(userole.user_id)
    end
    @locations = Location.all
    @users_info = Array.new
    admins.each do |user|
      user_info = Hash.new
      user_info["id"] = user.id
      user_info["email"] = user.email
      user_info["geofences"] = if user.locations
                                 user.locations
                               else
                                 []
                               end
      user_info["is_active"] = user.is_active
      user_info["last_access"] = user.last_sign_in_at
      @users_info << user_info
    end
    @users_info
  end

  def set_geofences
    admin = User.find(params["id"])
    locations = Location.all
    admin.destroy_geofences
    locations.each do |location|
      if params[location.name]
        AdminLocation.create(user_id:admin.id, location_id:location.id)
      end
    end
    respond_to do |f|
      f.js
    end
  end
end
