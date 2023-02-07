require 'rails_helper'

RSpec.describe 'tagging', type: :feature do
  fixtures :users
  before do
    @alice = users(:alice)
    sign_in @alice
    @place = @alice.places.create!(
      name: "Awesome new place",
      latitude: 1,
      longitude: 1
    )
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
