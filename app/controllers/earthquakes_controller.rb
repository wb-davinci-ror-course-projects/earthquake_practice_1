class EarthquakesController < ApplicationController
  before_action :set_earthquake, only: [:show, :edit, :update, :destroy]

  # GET /earthquakes
  # GET /earthquakes.json
  def index
    @earthquakes = Earthquake.all
    @earthquake_data_by_hour = @earthquakes.map{|earthquake| earthquake.time.hour}.inject(Hash.new(0)) {|h,i| h[i] += 1; h }
    @earthquake_data = @earthquakes.map{|earthquake| earthquake.mag.to_f.round(0)}.each_with_object(Hash.new(0)) { |mag,magnitudes| magnitudes[mag] += 1 }
    @earthquake_places = @earthquakes.map{|earthquake| convert(earthquake.place.split(',').last) }.each_with_object(Hash.new(0)) { |mag,magnitudes| magnitudes[mag] += 1 }
  end

  def upload
  end

  def process_csv
    number_of_earthquakes = Earthquake.import_csv(params[:file])
    redirect_to root_path,
      notice: "#{number_of_earthquakes} earthquakes created"
  end

  # GET /earthquakes/1
  # GET /earthquakes/1.json
  def show
  end

  # GET /earthquakes/new
  def new
    @earthquake = Earthquake.new
  end

  # GET /earthquakes/1/edit
  def edit
  end

  # POST /earthquakes
  # POST /earthquakes.json
  def create
    @earthquake = Earthquake.new(earthquake_params)

    respond_to do |format|
      if @earthquake.save
        format.html { redirect_to @earthquake, notice: 'Earthquake was successfully created.' }
        format.json { render :show, status: :created, location: @earthquake }
      else
        format.html { render :new }
        format.json { render json: @earthquake.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /earthquakes/1
  # PATCH/PUT /earthquakes/1.json
  def update
    respond_to do |format|
      if @earthquake.update(earthquake_params)
        format.html { redirect_to @earthquake, notice: 'Earthquake was successfully updated.' }
        format.json { render :show, status: :ok, location: @earthquake }
      else
        format.html { render :edit }
        format.json { render json: @earthquake.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /earthquakes/1
  # DELETE /earthquakes/1.json
  def destroy
    @earthquake.destroy
    respond_to do |format|
      format.html { redirect_to earthquakes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_earthquake
      @earthquake = Earthquake.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def earthquake_params
      params.require(:earthquake).permit(:time, :latitude, :longitude, :depth, :mag, :magtype, :nst, :gap, :dmin, :rms, :net, :usgs_ident, :updated, :place, :event_type)
    end

  def convert(country)
    if [" Alaska", " California", " Oregon", " Puerto Rico", " Hawaii", " Washington", " Nevada", " Montana", " U.S. Virgin Islands", " Wyoming", " Oklahoma", " Utah", " Idaho", " Arkansas", " Missouri", " Tennessee", " Texas", " CA", " New York", " Colorado", " Arizona", " Ohio", " Massachusetts", " Kansas"].include?(country)
      "United States"
    else
      country
    end
  end
end
