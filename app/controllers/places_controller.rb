class PlacesController < ApplicationController
  def edit
    @place = Place.find(params[:id])
  end
  def update
    @place = Place.find(params[:id])
    @place.update!(place_params)
    redirect_back(fallback_location: place_path(@place))
  end
  private
  def place_params
    params.require(:place).permit(:name)
  end
end