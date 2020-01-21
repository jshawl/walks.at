module Api
  class PlacesController < ApplicationController
    skip_before_action :verify_authenticity_token
    def create
      @place = current_user.places.create!(name: params[:name], latitude: params[:latitude], longitude: params[:longitude])
      render json: @place
    end
    def index
      render json: current_user.places
    end
    def destroy
      current_user.places.find(params[:id]).destroy!
      head 200
    end
  end
end