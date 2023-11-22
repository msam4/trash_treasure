class PlacesController < ApplicationController
  def index
    @places = Place.all

    @markers = @places.geocoded.map do |place|
      {
        lat: place.latitude,
        lng: place.longitude,
        marker_html: render_to_string(partial: "marker")
      }
    end
  end

  def show
  end

  def filter
    @places = []
    @trash_bins = []
  end

  private

  def bin_survey_params
    params.require(:bin_survey).permit(:full, :trash_type)
  end
end
