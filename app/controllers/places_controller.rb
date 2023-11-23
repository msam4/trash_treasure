class PlacesController < ApplicationController
  def index
    categories = params[:filter][:category]

    if categories
      # filter logic
      # Example of filtered category
      # ["", "pet_bottle.png", "can.png"]
      checked = categories.map do |category|
        key = Item::CATEGORY.key(category)
        key if key
      end
      @places = Place.joins(:trash_bins).where(trash_bins: { category: checked })
      #After the checked example if you filtered only PET bottle and can
      # ["PET bottle", "can"]
    else
      @places = Place.all
    end
    @markers = []
    @places.each do |place|
      @markers <<
        {
          lat: place.latitude,
          lng: place.longitude,
          info_window_html: render_to_string(partial: "info_window", locals: {place: place}),
          marker_html: render_to_string(partial: "marker")
        }
    end
  end

  def filter
    # Leave here in order to display the filter page
    @places = []
    @trash_bins = []
  end

  def show
    @place = Place.find(params[:id])
    @bins = @place.trash_bins
  end

  def new
    @place = Place.new
  end

  def create
    @place = Place.new(place_params)
    if @place.save
      redirect_to place_path(@place)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def bin_survey_params
    params.require(:bin_survey).permit(:full, :trash_type)
  end

  def place_params
    params.require(:place).permit(:name, :description, :longitude, :latitude, photos: [])
  end
end
