class AdminBlackListsController < ApplicationController
  before_action :set_admin_black_list, only: [:show, :edit, :update, :destroy]

  # GET /admin_black_lists
  # GET /admin_black_lists.json
  def index
    @admin_black_lists = AdminBlackList.all
  end

  # GET /admin_black_lists/1
  # GET /admin_black_lists/1.json
  def show
  end

  # GET /admin_black_lists/new
  def new
    @admin_black_list = AdminBlackList.new
  end

  # GET /admin_black_lists/1/edit
  def edit
  end

  # POST /admin_black_lists
  # POST /admin_black_lists.json
  def create
    @admin_black_list = AdminBlackList.new(admin_black_list_params)

    respond_to do |format|
      if @admin_black_list.save
        format.html { redirect_to @admin_black_list, notice: 'Admin black list was successfully created.' }
        format.json { render :show, status: :created, location: @admin_black_list }
      else
        format.html { render :new }
        format.json { render json: @admin_black_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin_black_lists/1
  # PATCH/PUT /admin_black_lists/1.json
  def update
    respond_to do |format|
      if @admin_black_list.update(admin_black_list_params)
        format.html { redirect_to @admin_black_list, notice: 'Admin black list was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_black_list }
      else
        format.html { render :edit }
        format.json { render json: @admin_black_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_black_lists/1
  # DELETE /admin_black_lists/1.json
  def destroy
    @admin_black_list.destroy
    respond_to do |format|
      format.html { redirect_to admin_black_lists_url, notice: 'Admin black list was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_black_list
      @admin_black_list = AdminBlackList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_black_list_params
      params.require(:admin_black_list).permit(:black_list_id, :user_id)
    end
end
