# frozen_string_literal: true

describe 'Event' do
  it 'fetches from the api' do
    d = {
      'Date' => '2023-01-01'
    }
    stub_request(:get, %r{https://www.followmee.com/api/tracks.aspx(.*)})
      .to_return(status: 200, body: "{\"Data\": [#{d.to_json}]}", headers: {})
    expect { Event.recent }.to change { Event.count }.by(1)
  end
end
