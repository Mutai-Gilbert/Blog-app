require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe 'User index page' do
    before do
      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(User.create(name: 'Kipkoech', photo: 'https://unsplash.com/photos',
                                bio: 'A developer from Kenya.'))
      @first_user = User.create(name: 'Mutai', photo: 'https://randomuser.me/api/portraits/women/67.jpg',
                                bio: 'A developer from Kenya.')
      User.create(name: 'Gilloh', photo: 'https://randomuser.me/api/portraits/women/70.jpg',
                  bio: 'A developer from Kenya.')
      visit root_path
    end
    it 'I can see the username of all other users.' do
      expect(page).to have_content('Kipkoech')
      expect(page).to have_content('Mutai')
      expect(page).to have_content('Gilloh')
    end
    it 'I can see the profile picture for each user.' do
      expect(page).to have_css("img[src='https://unsplash.com/photos']")
      expect(page).to have_css("img[src='https://randomuser.me/api/portraits/women/67.jpg']")
      expect(page).to have_css("img[src='https://randomuser.me/api/portraits/women/70.jpg']")
    end
    it 'I can see the number of posts each user has written.' do
      Post.create(author: @first_user, title: 'My first post', text: 'This is my first post')
      expect(page).to have_content('Number of posts: 1')
    end
    it 'When I click on a user, I am redirected to that users show page.' do
      click_link('Gilloh')
      expect(page).to have_current_path(user_path(@first_user))
    end
  end
end
