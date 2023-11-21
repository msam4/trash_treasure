class PlacesController < ApplicationController
  def index
  end

  def filter
    @places = []
    @trash_bins = []
  end
end
