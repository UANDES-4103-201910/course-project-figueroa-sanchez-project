class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit

  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    UserRole.create(role_id:1, user_id:@user.id)
    UserRole.create(role_id:2, user_id:@user.id)
    if @user.save
      redirect_back(fallback_location: root_path); flash[:success] = "Administrator successfully created"
    else
      redirect_back(fallback_location: root_path); flash[:danger] = "Error creating administrator"
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user_to_update = User.find(user_params[:id])
    if @user_to_update.update(user_params)
      redirect_back(fallback_location: root_path); flash[:success] = "User was successfully edited"
    else
      redirect_back(fallback_location: root_path); flash[:danger] = "Error editing user"
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path); flash[:success] = 'User was successfully destroyed.' }
      format.json { head 200 }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:id, :email, :password, :is_active)
    end

  
end
