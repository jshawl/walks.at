class PlacesController < ApplicationController
  def edit
    @place = current_user.places.find(params[:id])
  end
  def index
    @places = current_user.places
  end
  def update
    @place = current_user.places.find(params[:id])
    @place.update!(place_params)
    redirect_back(fallback_location: place_path(@place))
  end
  private
  def place_params
    params.require(:place).permit(:name)
  end
end