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
    if current_user
      @new_comment = Comment.new(user_id: current_user.id)
    end
    @shared_posts = Array.new
    @up_posts = Array.new
    @down_posts = Array.new
    @user_comments = Comment.get_posts_by_comments(@profile.user_id)

    all_shared_posts = SharedPost.all
    all_voted_posts = Validation.all


    if all_shared_posts.length > 0
      shared_post_first = all_shared_posts.where(user_id: @user.id).first
    end
    if shared_post_first
      @shared_posts = shared_post_first.get_shared_posts
    end

    if all_voted_posts.length > 0
      voted_post_first = all_voted_posts.where(user_id: @user.id).first
    end
    if voted_post_first
      @up_posts = voted_post_first.get_voted_posts['up']
      @down_posts = voted_post_first.get_voted_posts['down']
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
    comment = Comment.create(post: Post.find_by_id(params[:current_post]), user: current_user, comment: params[:new_comment])
    redirect_back(fallback_location: root_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      profile = Profile.where(id: params[:id])
      if profile.length > 0
        @profile = Profile.find(params[:id])
      else
        render :template => '/error_pages/404', :layout => false, :status => :not_found
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:id, :user, :first_name, :last_name, :bio, :country, :city, :image)
    end
end
