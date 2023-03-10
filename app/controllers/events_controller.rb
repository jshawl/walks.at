# frozen_string_literal: true

class EventsController < ApplicationController
  def index
    @events = if params[:date]
                current_user.events.by_date(params[:date])
              else
                current_user.events.grouped_by_date
              end
    @place = params[:date] ? @events.last : Place.new
  end
end
