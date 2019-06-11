class SearchesController < ApplicationController

  def new
    @search = Search.new
  end

  def create
    params = search_params
    params['user'] = current_user
    @search = Search.new(params)
    respond_to do |format|
      if @search.save
        format.html { redirect_to @search, notice: 'Search was successfully created.' }
        format.json { render :show, status: :created, location: @search }
      else
        format.html { render :new }
        format.json { render json: @search.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @search = Search.find(params[:id])
    @new_search = Search.new
    @users_by_name = Profile.get_profile_by_name(@search.keywords)
    @users_by_location = Profile.get_profile_by_location(@search.keywords)
    @posts_by_word = Post.get_post_by_word(@search.keywords)
    @posts_by_author = Post.get_post_by_author(@search.keywords)

  end


  private

  def search_params
    params.require(:search).permit(:id, :user, :keywords, :profile, :location)
  end

end
