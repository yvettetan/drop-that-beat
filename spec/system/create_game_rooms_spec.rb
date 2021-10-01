require 'rails_helper'

RSpec.describe 'CreateGameRooms', :vcr, type: :system do
  include_context 'when user creates a game room'

  before do
    driven_by(:selenium_chrome_headless)
    visit root_path
  end

  context 'with valid attributes', vcr: 'tracks/dua_lipa' do
    before do
      submit_form('animal')
      search_tracks
      add_tracks
    end

    it 'creates room' do
      click_on 'Finish setup'
      expect(Room.count).to eq 1
    end

    it 'shows game setup details', :aggregate_failures do
      expect(page).to have_content 'Create a Playlist'
      expect(page).to have_content 'Set Rounds'
    end

    it 'saves data' do
      click_on 'Finish setup'
      expect(room).to have_attributes(name: 'animal')
    end

    it 'redirects to homepage' do
      click_on 'Finish setup'
      expect(page).to have_content room.name
    end

    it 'generates success message' do
      click_on 'Finish setup'
      expect(page).to have_content 'Game was setup successfully'
    end
  end

  context 'with blank room name' do
    it 'generates an error message' do
      submit_form(nil)
      message = page.find('#room_name').native.attribute('validationMessage')
      expect(message).to eq 'Please fill out this field.'
    end
  end

  context 'with less than 5 tracks' do
    before do
      submit_form('animal')
      click_on 'Finish setup'
    end

    it 'generates an error nessage' do
      expect(page).to have_content 'Tracks must be at least 5'
    end
  end
end
