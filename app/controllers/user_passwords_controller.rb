class UserPasswordsController < ApplicationController
  before_action :set_user_password, only: [:show, :edit, :update, :destroy]

  # GET /user_passwords
  # GET /user_passwords.json
  def index
    @user_passwords = UserPassword.all
  end

  # GET /user_passwords/1
  # GET /user_passwords/1.json
  def show
  end

  # GET /user_passwords/new
  def new
    @user_password = UserPassword.new
  end

  # GET /user_passwords/1/edit
  def edit
  end

  # POST /user_passwords
  # POST /user_passwords.json
  def create
    @user_password = UserPassword.new(user_password_params)

    respond_to do |format|
      if @user_password.save
        format.html { redirect_to @user_password, notice: 'User password was successfully created.' }
        format.json { render :show, status: :created, location: @user_password }
      else
        format.html { render :new }
        format.json { render json: @user_password.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_passwords/1
  # PATCH/PUT /user_passwords/1.json
  def update
    respond_to do |format|
      if @user_password.update(user_password_params)
        format.html { redirect_to @user_password, notice: 'User password was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_password }
      else
        format.html { render :edit }
        format.json { render json: @user_password.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_passwords/1
  # DELETE /user_passwords/1.json
  def destroy
    @user_password.destroy
    respond_to do |format|
      format.html { redirect_to user_passwords_url, notice: 'User password was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_password
      @user_password = UserPassword.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_password_params
      params.require(:user_password).permit(:user, :password)
    end
end
