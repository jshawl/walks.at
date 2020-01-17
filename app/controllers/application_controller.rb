class ApplicationController < ActionController::Base
  def root
    @num_events = Event.count
    @date_from = params[:date_from] || Event.first.created_at.strftime("%F")
    @date_to = params[:date_to] || Event.last.created_at.strftime("%F")
  end
end
