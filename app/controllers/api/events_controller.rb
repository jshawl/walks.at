module Api
  class EventsController < ApplicationController
    def index
      params.require([:date_from, :date_to])
      render json: current_user.events.between(params[:date_from], params[:date_to])
    end
  end
end