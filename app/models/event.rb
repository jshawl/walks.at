require 'net/http'

class Event < ApplicationRecord
  validates :created_at, uniqueness: true
  def self.recent
    yesterday = (Time.now - 1.day).strftime("%F")
    tomorrow = (Time.now + 1.day).strftime("%F")
    url = "/api/tracks.aspx?key=#{Rails.application.credentials.FOLLOWMEE_API_KEY}&username=#{Rails.application.credentials.FOLLOWMEE_USERNAME}&output=json&function=daterangefordevice&from=#{yesterday}&to=#{tomorrow}&deviceid=#{Rails.application.credentials.FOLLOWMEE_DEVICE_ID}"
    res = Net::HTTP.get('www.followmee.com', url)
    data = JSON.parse(res)["Data"]
    data.each do |datum|
      create(
        created_at: datum["Date"],
        latitude: datum["Latitude"],
        longitude: datum["Longitude"],
        speed: datum["Speed(mph)"],
        direction: datum["Direction"],
        accuracy: datum["Accuracy"]
      )
    end
  end
end