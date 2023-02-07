# frozen_string_literal: true

require 'rails_helper'

describe 'places', type: :feature do
  fixtures :users
  before do
    setup_alice_place
  end
  it 'shows number of places' do
    visit places_path
    expect(page).to have_content('Places (1)')
  end
  it 'shows a place' do
    visit place_path(@place)
    expect(page).to have_content('Awesome new place')
  end
  it 'edits a place' do
    visit edit_place_path(@place)
    # it centers on lat lng
    expect(page.body).to match('1.0, 1.0')
  end
  it 'can create a new place' do
    visit new_place_path
    fill_in 'place_name', with: 'cool new place'
    click_on 'Create Place'
    expect(page).to have_content('cool new place')
    # TODO: test interacting with leaflet
    # and submitting the form
  end
  it 'can delete a place' do
    visit edit_place_path(@place)
    expect do
      click_on 'Delete'
    end.to change { Place.count }.by(-1)
  end
end
