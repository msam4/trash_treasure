class TossesController < ApplicationController
  def create
    @toss = Toss.new
    @place = Place.find(params[:place_id])
    @toss.place = @place
    @toss.user = current_user
    if @toss.save
      case current_user.tosses.count
      when 1
        redirect_to "/", notice: "You received the first toss badge!"
      when 5
        redirect_to "/", notice: "You received the 5 tosses badge!"
      when 10
        redirect_to "/", notice: "You received the 10 tosses badge!"
      else
        redirect_to "/"
      end
    else
      render "places/update_form", status: :unprocessable_entity
    end
  end

  private

  # def params_toss
  #   params.require(:toss).permit(:place_id)
  # end
end
