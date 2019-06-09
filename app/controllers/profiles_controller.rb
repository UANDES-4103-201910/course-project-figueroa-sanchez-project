class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:create, :update]

  $current_post = 0

  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = Profile.all
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
    @profile = Profile.find(params[:id])
    @user = User.find(@profile.user_id)
    @posts_raw = Post.where(user_id: @user.id).order(created_at: :desc)
    @posts = Array.new
    @posts_raw.each do |post|
      if not post.is_in_dumpster?
        @posts << post
      end
    end
    @votes = Hash.new
    @comments = Hash.new
    @posts.each do |post|
      @votes[post.id] = post.get_votes
      @comments[post.id] = Comment.get_post_comments(post.id)
    end
    @new_post = Post.new
    @new_comment = ""
    @following_posts = Array.new
    follow_post_current_user = FollowPost.all
    if follow_post_current_user.length > 0
      follow_post_first = follow_post_current_user.where(user_id: @user.id).first
    end
    if follow_post_first
      @following_posts = follow_post_first.get_following_posts
    end
  end

  # GET /profiles/new
  def new
    @profile = Profile.new
  end

  # GET /profiles/1/edit
  def edit
  end

  # POST /profiles
  # POST /profiles.json
  def create
    parameters = profile_params
    parameters["user"] = current_user
    current_user.is_active = true
    UserRole.create(role_id:1, user_id:current_user.id)
    current_user.update(is_active:true)
    @profile = Profile.create(parameters)
    redirect_to root_path
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    params = profile_params
    params.delete("id")
    params.delete("user")
    respond_to do |format|
      if @profile.update(params)
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy

  end

  def new_comment
    comment = Comment.create(post: Post.find_by_id(params[:current_post]) , user: current_user, comment: params[:new_comment])
    redirect_back(fallback_location: root_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:id, :user, :first_name, :last_name, :bio, :country, :city, :image)
    end
end
