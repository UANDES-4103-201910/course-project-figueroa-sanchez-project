class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  $new_comment = ""
  $current_post = 0
  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = Profile.all
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
    @profile = Profile.where(user_id:params[:id]).first
    @user = User.find(params[:id])
    @posts = Post.where(user_id: params[:id]).order(created_at: :desc)
    @votes = Hash.new
    @comments = Hash.new
    @posts.each do |post|
      @votes[post.id] = post.get_votes
      @comments[post.id] = Comment.get_post_comments(post.id)
    end
    @new_post = Post.new
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
    current_user.update(is_active:true)
    @profile = Profile.create(parameters)
    UserRole.create(user_id:current_user.id, role_id:1)
    redirect_to root_path
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    @profile_to_update = Profile.find(params[:id])
    # @profile_to_update.image.attach(params[:image])
    respond_to do |format|
      if @profile.update(profile_params)
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
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def new_comment
    comment = Comment.create(post: Post.find_by_id(params[:current_post]) , user: current_user, comment: $new_comment)
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
