class PlacesController < ApplicationController
  before_action :authenticate_user!
  def edit
    @place = current_user.places.find(params[:id])
  end
  def show
    @place = current_user.places.find(params[:id])
  end
  def index
    @places = current_user.places.reverse
    @place = current_user.places.build
  end
  def new
    @place = current_user.places.build
  end
  def create
    @place = current_user.places.create!(place_params)
    redirect_back(fallback_location: place_path(@place))
  end
  def destroy
    @place = current_user.places.find(params[:id])
    @place.destroy!
    redirect_to places_path
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
