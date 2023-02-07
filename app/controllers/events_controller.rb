# frozen_string_literal: true

class EventsController < ApplicationController
  def index
    @events = current_user.events.where('created_at > ?', Date.yesterday)
    @place = @events.last
  end
end
