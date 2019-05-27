class ProfileLocationsController < ApplicationController
  before_action :set_profile_location, only: [:show, :edit, :update, :destroy]

  # GET /profile_locations
  # GET /profile_locations.json
  def index
    @profile_locations = ProfileLocation.all
  end

  # GET /profile_locations/1
  # GET /profile_locations/1.json
  def show
  end

  # GET /profile_locations/new
  def new
    @profile_location = ProfileLocation.new
  end

  # GET /profile_locations/1/edit
  def edit
  end

  # POST /profile_locations
  # POST /profile_locations.json
  def create
    @profile_location = ProfileLocation.new(profile_location_params)

    respond_to do |format|
      if @profile_location.save
        format.html { redirect_to @profile_location, notice: 'Profile location was successfully created.' }
        format.json { render :show, status: :created, location: @profile_location }
      else
        format.html { render :new }
        format.json { render json: @profile_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profile_locations/1
  # PATCH/PUT /profile_locations/1.json
  def update
    respond_to do |format|
      if @profile_location.update(profile_location_params)
        format.html { redirect_to @profile_location, notice: 'Profile location was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile_location }
      else
        format.html { render :edit }
        format.json { render json: @profile_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profile_locations/1
  # DELETE /profile_locations/1.json
  def destroy
    @profile_location.destroy
    respond_to do |format|
      format.html { redirect_to profile_locations_url, notice: 'Profile location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile_location
      @profile_location = ProfileLocation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_location_params
      params.require(:profile_location).permit(:profile, :location)
    end
end
