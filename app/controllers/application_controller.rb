class ApplicationController < ActionController::Base
  def root
    @date_from = params[:date_from] || Time.now.strftime("%F")
    @date_to = params[:date_to] || Time.now.strftime("%F")
    @num_events = current_user.events.between(@date_from, @date_to).count
  end
end
