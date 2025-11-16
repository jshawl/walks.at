# frozen_string_literal: true

require 'rails_helper'

describe 'Event' do
  fixtures :users
  it 'fetches from the api' do
    d = {
      'Date' => '2023-01-01'
    }
    stub_request(:get, %r{https://followmee.com/api/tracks.aspx(.*)})
      .to_return(status: 200, body: "{\"Data\": [#{d.to_json}]}", headers: {})
    expect { Event.recent }.to change { Event.count }.by(1)
  end
  it 'has a by_date scope' do
    Event.by_date(1.hour.ago.strftime('%F'))
  end
end
