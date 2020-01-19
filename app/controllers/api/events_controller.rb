module Api
  class EventsController < ApplicationController
    def index
      params.require([:date_from, :date_to])
      date_from = Date.parse(params[:date_from]).beginning_of_day
      date_to = Date.parse(params[:date_to]).end_of_day
      render json: current_user.events.where(created_at: date_from..date_to)
    end
  end
end