class PlacesController < ApplicationController
  def index
    @places = Place.all

    @markers = @places.geocoded.map do |bin|
      {
        lat: bin.latitude,
        lng: bin.longitude
      }
    end
  end

  def filter
    @places = []
    @trash_bins = []
  end

  def show
    @place = Place.find(params[:id])
    @bins = @place.trash_bins
  end

end
