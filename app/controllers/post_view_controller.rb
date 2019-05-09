class PostViewController < ApplicationController
  def index
    @post = Post.get_post(params[:id])

  end

  def post
  end
end
