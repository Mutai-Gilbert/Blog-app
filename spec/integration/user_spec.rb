require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe 'User index page' do
    before do
      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(User.create(name: 'Tom', photo: 'https://unsplash.com/photos', bio: 'Teacher from Mexico.',
                                post_counter: 0))
      @user = User.create(name: 'Gilbert', photo: 'https://randomuser.me/api/portraits/women/67.jpg',
                          bio: 'A developer from Kenya.', post_counter: 0)
      @first_post = Post.create(author_id: @user.id, title: 'First post', text: 'First post', comments_counter: 0,
                                likes_counter: 0)
      visit root_path
    end
    it 'I can see the username of all other user\'s.' do
      expect(page).to have_content('Tom')
      expect(page).to have_content('Gilbert')
    end
    it 'I can see the profile picture for each user.' do
      expect(page).to have_css("img[src='https://unsplash.com/photos']")
      expect(page).to have_css("img[src='https://randomuser.me/api/portraits/women/67.jpg']")
    end
    it 'I can see the number of posts each user has written.' do
      expect(page).to have_content('Number of posts: 1')
    end
    it 'When I click on a user, I am redirected to that users show page.' do
      click_link('Gilbert')
      expect(page).to have_current_path(user_path(@user))
    end
  end
end
