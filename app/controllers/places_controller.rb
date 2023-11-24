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

  def update_form
    @place = Place.find(params[:id])
    @bin = TrashBin.find_by(id: params[:bin_id])
    @bin ||= TrashBin.new
  end

  def update
    @place = Place.find(params[:id])
    @bin = TrashBin.find_or_initialize_by(place: @place)

    # Update is_present based on the button value
    @bin.is_present = params[:trash_bin][:is_present] == 'true'

    if @bin.save
      redirect_to root_path, notice: "Bin update recorded successfully!"
    else
      render :update_form, status: :unprocessable_entity
    end
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

  def bin_update_params
    params.require(:trash_bin).permit(:is_present, :category)
  end

  def place_params
    params.require(:place).permit(:name, :description, :longitude, :latitude, photos: [])
  end
end
