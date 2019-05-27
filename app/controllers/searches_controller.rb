class SearchesController < ApplicationController

  def new
    @search = Search.new(user_id: current_user.id)
  end

  def create
    @search = Search.create!(params[:search])
    redirect_to @search
  end

  def show
    @search = Search.find(params[:id])
  end


end
