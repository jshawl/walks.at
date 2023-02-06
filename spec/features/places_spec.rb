require 'rails_helper'

RSpec.describe 'places page', type: :feature do
  fixtures :users
  describe 'index' do
    it 'shows number of places' do
      sign_in users(:alice)
      visit places_path
      expect(page).to have_content('Places (0)')
    end
  end
  describe 'show' do
    it 'shows a place' do
      @alice = users(:alice)
      sign_in @alice
      @place = @alice.places.create!(
        name: "Awesome new place",
        latitude: 1,
        longitude: 1
      )
      visit place_path(@place)
      expect(page).to have_content('Awesome new place')
    end
  end
  describe 'edit' do
    it 'edits a place' do
      @alice = users(:alice)
      sign_in @alice
      @place = @alice.places.create!(
        name: "Awesome new place",
        latitude: 1,
        longitude: 1
      )
      visit edit_place_path(@place)
      # it centers on lat lng
      expect(page.body).to match('1.0, 1.0')
    end
  end
  describe 'new' do
    it 'can create a new place' do
      sign_in users(:alice)
      visit new_place_path
      expect(page).to have_current_path("/places/new")
      # TODO test interacting with leaflet
      # and submitting the form, e.g. just
      # invoke the save click handler
    end
  end
end
