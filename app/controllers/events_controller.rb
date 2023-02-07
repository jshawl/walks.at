# frozen_string_literal: true

class EventsController < ApplicationController
  def index
    set_events
    @place = @events.is_a?(ActiveRecord::AssociationRelation) ? @events.last : Place.new
  end

  private

  def set_events
    @events = if params[:date]
                date = Date.parse(params[:date]).beginning_of_day
                current_user.events.where('created_at >= ? AND created_at <= ?', date, date.end_of_day)
              else
                current_user.events.group('date(created_at)').count.sort.reverse
              end
  end
end
