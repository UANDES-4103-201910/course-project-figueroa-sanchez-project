# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end


  # POST /resource/sign_in
  def create
    user = User.find_by_email(params["user"]["email"].downcase)
    if user
      if not user.is_active
        flash[:danger] = "This account has been banned"
        root_path
      elsif user.is_suspended?
        flash[:danger] = "This account has been suspended until #{user.suspension_time}"
        root_path
      else
        super
      end
    else
      super
    end
  end

    # DELETE /resource/sign_out
    # def destroy
    #   super
    # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
