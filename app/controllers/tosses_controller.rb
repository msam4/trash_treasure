class TossesController < ApplicationController
  def create
    @toss = Toss.new
    @place = Place.find(params[:place_id])
    @toss.place = @place
    @toss.user = current_user
    if @toss.save
      redirect_to "/"
    else
      render "places/update_form", status: :unprocessable_entity
    end
  end

  private

  # def params_toss
  #   params.require(:toss).permit(:place_id)
  # end
end
