class PlacesController < ApplicationController
  def index
    categories = params[:filter][:category]
    categories.reject! { |category| category.empty? }

    if categories.any?
      # filter logic
      # Example of filtered category
      # ["", "pet_bottle.png", "can.png"]
      @checked = categories.map do |category|
        key = Item::CATEGORY.key(category)
        key if key
      end
      # @places = Place.joins(:trash_bins).where(trash_bins: { category: @checked }).group("places.id").having("COUNT(DISTINCT places.trash_bins.category)=?",@checked.length)
      places = Place.all.select{|place| @checked.all?{|category| mapped_list(place).include?(category)}}
      @places = Place.where(id: places.map(&:id))
      #After the checked example if you filtered only PET bottle and can
      # ["PET bottle", "can"]
      if params[:filter][:latitude].present? && params[:filter][:longitude].present?
        near_places = @places.near([params[:filter][:latitude].to_f, params[:filter][:longitude].to_f], 10)
        @no_bins_nearby = near_places.empty?
        @places = near_places unless @no_bins_nearby
       end
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
    @toss = Toss.new
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
    @place.user = current_user
  end

  def new_photo
    @place = Place.find(params[:id])
  end


  def save_photo
     @place = Place.find(params[:id])

     # Update @place with new photos
    if params[:place] && params[:place][:photos]
      @place.photos.attach(params[:place][:photos])
    end

    if @place.save
      redirect_to place_path(@place), notice: "Thank you for your contribution. The beautiful picture(s) was added"
    else
      render :new, status: :unprocessable_entity
    end
  end


  def create
    @place = Place.new(place_params)
    @place.user = current_user
    if @place.save
      case current_user.places.count
      when 1
        redirect_to place_path(@place), notice: "Place was successfully added. And you received the Add a new place badge!"
      when 5
        redirect_to place_path(@place), notice: "Place was successfully added. And you received the Add 5 new places badge!"
      when 10
        redirect_to place_path(@place), notice: "Place was successfully added. And you received the Add 10 new places badge!"
      else
        redirect_to place_path(@place), notice: "Place was successfully added."
      end
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

  def mapped_list(place)
    place.trash_bins.map{|bin| bin.category}
  end
end
