# frozen_string_literal: true

require 'net/http'

class Event < ApplicationRecord
  validates :created_at, uniqueness: true
  belongs_to :user
  def self.recent
    yesterday = (Time.now - 1.day).strftime('%F')
    tomorrow = (Time.now + 1.day).strftime('%F')
    get_followmee_data(yesterday, tomorrow).map do |d|
      User.first.events.create(
        formatted_data(d)
      )
    end
  end

  def self.get(url)
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    JSON.parse(http.get(uri.request_uri).body)
  end

  def self.get_followmee_data(date_from, date_to)
    url = "https://www.followmee.com/api/tracks.aspx?key=#{Rails.application.credentials.FOLLOWMEE_API_KEY}&username=#{Rails.application.credentials.FOLLOWMEE_USERNAME}&output=json&function=daterangefordevice&from=#{date_from}&to=#{date_to}&deviceid=#{Rails.application.credentials.FOLLOWMEE_DEVICE_ID}"
    get(url)['Data']
  end

  def self.formatted_data(datum)
    {
      created_at: datum['Date'],
      latitude: datum['Latitude'],
      longitude: datum['Longitude'],
      speed: datum['Speed(mph)'],
      direction: datum['Direction'],
      accuracy: datum['Accuracy']
    }
  end
end
