require 'rails_helper'

RSpec.describe 'CreateGameRooms', type: :system do
  include_context 'when user creates a game room'

  before do
    driven_by(:rack_test)
    visit root_path
  end

  context 'with valid attributes' do
    before { submit_form('animal') }

    it 'creates room' do
      expect(Room.count).to eq 1
    end

    it 'shows game setup details', :aggregate_failures do
      expect(page).to have_content 'Create a Playlist'
      expect(page).to have_content 'Set Rounds'
    end

    it 'saves data' do
      expect(room).to have_attributes(name: 'animal')
    end
  end

  context 'with blank room name' do
    it 'generates an error message' do
      submit_form(nil)
      expect(page).to have_content 'Name can\'t be blank'
    end
  end
end