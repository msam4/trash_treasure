class PlacesController < ApplicationController
  def index
    @bins = TrashBin.all

    @markers = @bins.geocoded.map do |bin|
      {
        lat: bin.latitude,
        lng: bin.longitude
      }
    end
  end

  def show
  end

  def filter
    @places = []
    @trash_bins = []
  end
end
