# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # def root
  #   authenticate_user!
  #   @date_from = params[:date_from] || Time.now.strftime("%F")
  #   @date_to = params[:date_to] || Time.now.strftime("%F")
  #   @num_events = current_user.events.between(@date_from, @date_to).count
  # end
  before_action :add_source_version_header

  def add_source_version_header
    headers['X-Source-Version'] = ENV.fetch('SOURCE_VERSION', nil)
  end
end
