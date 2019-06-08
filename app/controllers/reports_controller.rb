class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /reports
  # GET /reports.json
  def index
    reported_posts = Report.get_reported_posts
    @reports = Array.new
    reported_posts.each do |post|
      report = Hash.new
      report["post_title"] = post.title
      report["author"] = post.get_user_mail
      report["date"] = post.created_at
      report["reports"] = post.get_reports
      report["reports_count"] = post.count_reports
      report["post_id"] = post.id.to_s
      @reports << report
    end
  end

  # GET /reports/1
  # GET /reports/1.json
  def show
  end

  # GET /reports/new
  def new
    @report = Report.new
    @post = Post.find(params[:post_id])
  end

  # GET /reports/1/edit
  def edit
  end

  # POST /reports
  # POST /reports.json
  def create
    r_params = report_params
    r_params[:user] = current_user
    r_params[:post] = Post.find(params["post_id"])
    category = ReportCategory.find(r_params[:report_category].to_i)
    r_params[:report_category] = category
    @report = Report.new(r_params)
    respond_to do |format|
      if @report.save
        format.html {redirect_back(fallback_location: root_path); flash[:success] = "Post successfully reported"}
      else
        format.html {redirect_back(fallback_location: root_path); flash[:danger] = "Error reporting post"}
      end
    end
  end

  # PATCH/PUT /reports/1
  # PATCH/PUT /reports/1.json
  def update
    respond_to do |format|
      if @report.update(report_params)
        format.html { redirect_to @report, notice: 'Report was successfully updated.' }
        format.json { render :show, status: :ok, location: @report }
      else
        format.html { render :edit }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    @report.destroy
    respond_to do |format|
      format.html { redirect_to reports_url, notice: 'Report was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def report_params
      params.require(:report).permit(:user, :post, :report_category, :comment)
    end
end
