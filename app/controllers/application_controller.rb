class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :get_profile

  def after_sign_in_path_for(resource)
    if resource.roles.first
      name = resource.roles.first.name
      if name == "administrator"
        admin_home_path
      else
        root_path
      end
    else
      root_path
    end
  end

  def after_sign_up_path_for(resource)
    new_profile_url
  end

  def get_profile
    if profile_available
      @current_profile = Profile.find_by_user_id(current_user.id)
    end
  end

  def profile_available
    if current_user
      profile = Profile.where(user_id: current_user.id)
      if profile.length == 0
        false
      else
        true
      end
    end
  end

  def check_profile
    if not profile_available
      redirect_to new_profile_url
    end
  end
end

