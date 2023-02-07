# frozen_string_literal: true

namespace :followmee do
  desc 'get events from followmee api'
  task get_events: :environment do
    Event.recent
  end
end
