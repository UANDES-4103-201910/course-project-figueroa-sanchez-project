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
    @posts = @search.posts
  end


  private

  def search_params
    params.require(:search).permit(:id, :user, :keywords, :profile, :location)
  end

end
