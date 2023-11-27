
class TrashBinsController < ApplicationController

  def new
    @place = Place.find(params[:place_id])
    @bin = TrashBin.new
  end


  def create
    @place = Place.find(params[:place_id])
    @bin = TrashBin.new(bin_params)
    @bin.place = @place
    if @bin.save
      redirect_to place_path(@place), notice: "Bin was successfully added. Do you want to add another?"
    else
      render "places/show", status: :unprocessable_entity
    end
  end

  private
  def set_bin
    @bin = TrashBin.find(params[:id])
  end

  def bin_params
    params.require(:trash_bin).permit(:category)
  end
end
