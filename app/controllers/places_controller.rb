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
      #After the checked example if you filtered only PET bottle and can
      # ["PET bottle", "can"]
      @bins = []
      checked.each do |check|
        checked_bin = TrashBin.where(category: check).to_a
        @bins += checked_bin
      end
    else
      @bins = TrashBin.all
    end

    @markers = @places.geocoded.map do |bin|
      {
        lat: bin.latitude,
        lng: bin.longitude,
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

  private

  def bin_survey_params
    params.require(:bin_survey).permit(:full, :trash_type)
  end
end
