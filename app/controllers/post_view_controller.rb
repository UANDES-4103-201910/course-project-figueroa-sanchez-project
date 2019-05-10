class PostViewController < ApplicationController
  def index
    @post = Post.get_post(params[:id])
    @comments = Comment.get_post_comments(params[:id])
  end
  def post
  end
end
