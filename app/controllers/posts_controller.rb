class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!
  $current_post = 0
  $new_comment = ""
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.where(user_id: current_user)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.get_post(params[:id])
    $current_post = @post['id']
    @comments = Comment.get_post_comments(params[:id])
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    parameters = post_params
    parameters["user"] = current_user
    @post = Post.new(parameters)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head 200 }
    end
  end

  def vote_up
    validation = Validation.create(post: Post.find_by_id($current_post) , user: current_user, vote: 1)
    redirect_back(fallback_location: root_path)
  end

  def vote_down
    validation = Validation.create(post: Post.find_by_id($current_post) , user: current_user, vote: -1)
    redirect_back(fallback_location: root_path)
  end

  def follow_post
    follow_post = FollowPost.create(post: Post.find_by_id($current_post) , user: current_user)
    redirect_back(fallback_location: root_path)
  end

  def new_comment
    comment = Comment.create(post: Post.find_by_id($current_post) , user: current_user, comment: $new_comment)
    redirect_back(fallback_location: root_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :description, images: [], files: [])
    end
end
