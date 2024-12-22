# frozen_string_literal: true

namespace :followmee do
  desc 'get events from followmee api'
  task get_events: :environment do
    @events = Event.recent.filter(&:id).count
    Net::HTTP.get(URI.parse(Rails.application.credentials.HEALTHCHECK_URL)) if @events.positive?
  end
end
