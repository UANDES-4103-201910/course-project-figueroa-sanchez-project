class BlackListsController < ApplicationController
  before_action :set_black_list, only: [:show, :edit, :update]
  before_action :authenticate_user!
  # GET /black_lists
  # GET /black_lists.json
  def index
    black_list_raw = BlackList.all
    @black_list = Array.new
    black_list_admin = AdminBlackList.all

    black_list_raw.each do |item|
      user = User.find(item.user_id)
      author = black_list_admin.where(black_list_id: item.id)
      profile = Profile.where(user_id: item.user_id).first
      black_item = Hash.new
      black_item["black_list_id"] = item.id
      black_item["id"] = user.id
      black_item["first_name"] = profile.first_name
      black_item["last_name"] = profile.last_name
      black_item["email"] = user.email
      black_item["is_active"] = user.is_active
      @black_list << black_item
    end
  end

  # GET /black_lists/1
  # GET /black_lists/1.json
  def show
  end

  # GET /black_lists/new
  def new
    @black_list = BlackList.new
  end

  # GET /black_lists/1/edit
  def edit
  end

  # POST /black_lists
  # POST /black_lists.json
  def create
    user = User.find(params[:id])
    @black_list = BlackList.new(user_id: user.id)
    user_posts = user.posts
    user_posts.each do |post|
      if post.is_innapropiate?
        if not post.is_in_dumpster?
          Dumpster.create(post_id: post.id)
        end
      end
    end
    respond_to do |format|
      if @black_list.save
        format.html {redirect_back(fallback_location: black_list_path); flash[:success] = "User successfully blacklisted."}
      else
        format.html {redirect_back(fallback_location: black_list_path); flash[:danger] = "User is already in the blacklist."}
      end
    end

  end

  # PATCH/PUT /black_lists/1
  # PATCH/PUT /black_lists/1.json
  def update
    respond_to do |format|
      if @black_list.update(black_list_params)
        format.html {redirect_to @black_list, notice: 'Black list was successfully updated.'}
        format.json {render :show, status: :ok, location: @black_list}
      else
        format.html {render :edit}
        format.json {render json: @black_list.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /black_lists/1
  # DELETE /black_lists/1.json
  def destroy
    @black_list = BlackList.find(params[:id])
    user = User.find(@black_list.user_id)
    respond_to do |format|
      if not user.is_active
        format.html {redirect_back(fallback_location: black_list_path); flash[:danger] = 'Error: The user is banned'}

      elsif @black_list.destroy
        format.html {redirect_back(fallback_location: black_list_path); flash[:success] = 'User removed from Blacklist'}
      else
        format.html {redirect_back(fallback_location: black_list_path); flash[:danger] = 'Error removing from blacklist'}
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_black_list
    @black_list = BlackList.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def black_list_params
    params.require(:black_list).permit(:user)
  end
end
