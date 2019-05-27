class BlackListsController < ApplicationController
  before_action :set_black_list, only: [:show, :edit, :update, :destroy]

  # GET /black_lists
  # GET /black_lists.json
  def index
    black_list_raw = BlackList.all
    @black_list = Array.new
    black_list_admin = AdminBlackList.all
    admins_mails = User.get_admins_mails

    black_list_raw.each do |item|
      user = User.find(item.user_id)
      author = black_list_admin.where(black_list_id: item.id)

      profile = Profile.where(user_id: item.user_id).first
      black_item = Hash.new
      black_item["first_name"] = profile.first_name
      black_item["last_name"] = profile.last_name
      black_item["email"] = user.mail
      black_item["is_active"] = user.is_active
      if author.length != 0
        black_item["author"] = admins_mails[author.first.user_id]
      else
        black_item["author"] = ""
      end
      @black_list << black_item
    end
  end

  # GET /black_lists/1
  # GET /black_lists/1.json
  def show
  end

  # GET /black_lists/new
  def new
    @black_list = BlackList.new
  end

  # GET /black_lists/1/edit
  def edit
  end

  # POST /black_lists
  # POST /black_lists.json
  def create
    @black_list = BlackList.new(black_list_params)

    respond_to do |format|
      if @black_list.save
        format.html { redirect_to @black_list, notice: 'Black list was successfully created.' }
        format.json { render :show, status: :created, location: @black_list }
      else
        format.html { render :new }
        format.json { render json: @black_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /black_lists/1
  # PATCH/PUT /black_lists/1.json
  def update
    respond_to do |format|
      if @black_list.update(black_list_params)
        format.html { redirect_to @black_list, notice: 'Black list was successfully updated.' }
        format.json { render :show, status: :ok, location: @black_list }
      else
        format.html { render :edit }
        format.json { render json: @black_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /black_lists/1
  # DELETE /black_lists/1.json
  def destroy
    @black_list.destroy
    respond_to do |format|
      format.html { redirect_to black_lists_url, notice: 'Black list was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_black_list
      @black_list = BlackList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def black_list_params
      params.require(:black_list).permit(:user)
    end
end
