# frozen_string_literal: true

class PlacesController < ApplicationController
  before_action :authenticate_user!
  def edit
    @place = current_user.places.find(params[:id])
  end

  def show
    @place = current_user.places.find(params[:id])
  end

  def index
    @place = current_user.places.last
    @places = if params[:tag]
                current_user.places.tagged_with(params[:tag]).uniq
              else
                current_user.places
              end
  end

  def new
    @place = current_user.places.build
  end

  def create
    @place = current_user.places.create!(place_params)
    current_user.tag(@place, with: place_params[:tag_list], on: :places) if place_params[:tag_list]
    redirect_to place_path(@place)
  end

  def import
  end

  def import_upload
    data = JSON.parse(params[:places][:data].read)
    formatted_data = data[0][8].map do |place|
      current_user.places.create!(
        latitude: place[1][5][2],
        longitude: place[1][5][3],
        created_at: Time.at(place[9][0]),
        name: place[2]
      )
    end
    redirect_to places_path
  end

  def destroy
    @place = current_user.places.find(params[:id])
    @place.destroy!
    redirect_to places_path
  end

  def update
    @place = current_user.places.find(params[:id])
    @place.update!(place_params)
    current_user.tag(@place, with: place_params[:tag_list], on: :places) if place_params[:tag_list]
    redirect_to place_path(@place)
  end

  private

  def place_params
    params.require(:place).permit(:name, :tag_list, :latitude, :longitude)
  end
end
