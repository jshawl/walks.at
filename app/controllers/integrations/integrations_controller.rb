module Integrations
  class IntegrationsController < ApplicationController
    def moves
    end
    def moves_import
      places = JSON.parse(params[:places_json].tempfile.read)
      places.each do |date|
        date["segments"] && date["segments"].each do |segment|
          current_user.events.create(
            created_at: segment["startTime"],
            latitude: segment["place"]["location"]["lat"],
            longitude: segment["place"]["location"]["lon"]
          )
        end
      end
      redirect_to events_path
    end
  end
end
