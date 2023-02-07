# frozen_string_literal: true

require 'rails_helper'

describe 'tagging', type: :feature do
  fixtures :users
  before do
    setup_alice_place
  end
  it 'shows places by tag' do
    @alice.tag(@place, with: 'new, awesome', on: :places)
    visit places_path(tag: 'new')
    expect(page).to have_content('new: 1')
    visit places_path(tag: 'awesome')
    expect(page).to have_content('awesome: 1')
  end
  it 'shows existing tags for a place' do
    @alice.tag(@place, with: 'new, awesome', on: :places)
    visit place_path(@place)
    expect(page).to have_content('newawesome')
  end
  it 'can edit a tag on a place' do
    visit edit_place_path(@place)
    fill_in 'place_tag_list', with: 'newawesome'
    click_on 'Update Place'
    expect(page).to have_current_path(place_path(@place))
    expect(page.body).to have_content('newawesome')
  end
end
