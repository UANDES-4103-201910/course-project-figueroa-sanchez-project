class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def check_profile
    if current_user
      user_profile = Profile.where(user_id: current_user.id)
      if user_profile.length == 0
        redirect_to registration__url
      end
    end
  end

end
