require 'net/http'

class Event < ApplicationRecord
  validates :created_at, uniqueness: true
  belongs_to :user
  def self.recent
    yesterday = (Time.now - 1.day).strftime("%F")
    tomorrow = (Time.now + 1.day).strftime("%F")
    url = "/api/tracks.aspx?key=#{Rails.application.credentials.FOLLOWMEE_API_KEY}&username=#{Rails.application.credentials.FOLLOWMEE_USERNAME}&output=json&function=daterangefordevice&from=#{yesterday}&to=#{tomorrow}&deviceid=#{Rails.application.credentials.FOLLOWMEE_DEVICE_ID}"
    res = Net::HTTP.get('www.followmee.com', url)
    data = JSON.parse(res)["Data"]
    data.each do |datum|
      create(
        user: User.first,
        created_at: datum["Date"],
        latitude: datum["Latitude"],
        longitude: datum["Longitude"],
        speed: datum["Speed(mph)"],
        direction: datum["Direction"],
        accuracy: datum["Accuracy"]
      )
    end
  end
  def self.between(date_from,date_to)
    where(
      created_at:
        Date.parse(date_from).beginning_of_day-21600..
        Date.parse(date_to).end_of_day-21600
    )
  end
end