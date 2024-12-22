# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # def root
  #   authenticate_user!
  #   @date_from = params[:date_from] || Time.now.strftime("%F")
  #   @date_to = params[:date_to] || Time.now.strftime("%F")
  #   @num_events = current_user.events.between(@date_from, @date_to).count
  # end
  before_action :add_commit_header

  def add_commit_header
    headers['X-Commit'] = ENV.fetch('HEROKU_BUILD_COMMIT', nil)
  end
end
