class UserRolesController < ApplicationController
  before_action :set_user_role, only: [:show, :edit, :update]
  before_action :authenticate_user!
  # GET /user_roles
  # GET /user_roles.json
  def index
    @user_roles = UserRole.all
  end

  # GET /user_roles/1
  # GET /user_roles/1.json
  def show
  end

  # GET /user_roles/new
  def new
    @user_role = UserRole.new
  end

  # GET /user_roles/1/edit
  def edit
  end

  # POST /user_roles
  # POST /user_roles.json
  def create
    @user_role = UserRole.new(role_id: 2, user_id: params[:id])
    respond_to do |format|
      if @user_role.save
        format.html {redirect_back(fallback_location: super_admin_home_path); flash[:success] = 'Succesfully promoted to admin.'}
        format.json {render :show, status: :created, location: @user_role}
      else
        format.html {redirect_back(fallback_location: super_admin_home_path); flash[:danger] = 'User is already admin.'}
        format.json {render json: @user_role.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /user_roles/1
  # PATCH/PUT /user_roles/1.json
  def update
    respond_to do |format|
      if @user_role.update(user_role_params)
        format.html {redirect_to @user_role, notice: 'User role was successfully updated.'}
        format.json {render :show, status: :ok, location: @user_role}
      else
        format.html {render :edit}
        format.json {render json: @user_role.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /user_roles/1
  # DELETE /user_roles/1.json
  def destroy
    @user_role = UserRole.where(user_id: params[:id], role_id: 2).first
    respond_to do |format|
      if @user_role.destroy
        format.html {redirect_back(fallback_location: super_admin_home_path); flash[:success] = 'Succesfully demoted.'}
      else
        format.html {redirect_back(fallback_location: super_admin_home_path); flash[:danger] = 'Error demoting admin.'}
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user_role
    @user_role = UserRole.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_role_params
    params.require(:user).permit(:role, :user)
  end
end
