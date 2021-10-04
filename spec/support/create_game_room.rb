RSpec.shared_context 'when user creates a game room' do
  include_context 'when user is logged in'
  let(:room) { user.rooms.find_by(name: 'animal') }

  def submit_form(room_name)
    fill_in 'room_name', with: room_name
    click_on 'Create Room'
  end

  def update_rounds(rounds)
    select rounds, from: 'Rounds'
    click_on 'Finish setup'
  end

  def update_room_name(name)
    fill_in 'name', with: name
  end

  def search_tracks(track_name)
    fill_in 'Search track', with: track_name
    click_on 'Search'
  end

  def add_tracks
    within '#track_results' do
      all('a').each(&:click)
    end
  end
end
