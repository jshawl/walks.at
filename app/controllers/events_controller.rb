class EventsController < ApplicationController
  def index
    @events = current_user.events.where('created_at > ?',Date.today)
    @place = @events.last
  end
end
