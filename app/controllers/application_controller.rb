class ApplicationController < ActionController::Base
  def root
    @num_events = Event.count
  end
end
