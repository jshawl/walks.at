class ApplicationController < ActionController::Base
  def root
    @num_events = Event.count
    @date_from = params[:date_from] || Time.now.strftime("%F")
    @date_to = params[:date_to] || Time.now.strftime("%F")
  end
end
