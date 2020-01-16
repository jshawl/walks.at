namespace :followmee do
  desc "TODO"
  task get_events: :environment do
    Event.recent
  end
end
