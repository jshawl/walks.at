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
    expect(page).to have_current_path("/places/new")
    # TODO test interacting with leaflet
    # and submitting the form, e.g. just
    # invoke the save click handler
  end
  it 'can delete a place' do
    visit edit_place_path(@place)
    expect{
      click_on "Delete"
    }.to change{Place.count}.by(-1)
  end
end
