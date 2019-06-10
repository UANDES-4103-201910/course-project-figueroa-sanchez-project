class ApplicationController < ActionController::Base
  before_action :get_profile

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
    if not profile_available and user_signed_in?
      redirect_to new_profile_url
    end
  end
end

