# frozen_string_literal: true

require 'rails_helper'

describe 'integrations/moves', type: :feature do
  fixtures :users
  it 'can upload a places.json file' do
    sign_in users(:alice)
    visit integrations_moves_path
    attach_file("places_json", Rails.root + "spec/fixtures/places.json")
    expect {
      click_on "Submit"
    }.to change{Event.count}.by(1)
    expect(Event.last.latitude).to eq(38.12345678)
    expect(page).to have_current_path(events_path)
  end
end
