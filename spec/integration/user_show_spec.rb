require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe 'user show page' do
    before do
      @first_user = User.create(name: 'Gilbert', photo: 'https://unsplash.com/photos', bio: 'A developer from Kenya.',
                                post_counter: 0)
      @first_post = Post.create(author: @first_user, title: 'first', text: 'This is my first post',
                                comments_counter: 0, likes_counter: 0)
      Post.create(author: @first_user, title: 'second', text: 'This is my second post', comments_counter: 0,
                  likes_counter: 0)
      Post.create(author: @first_user, title: 'third', text: 'This is my third post', comments_counter: 0,
                  likes_counter: 0)
      visit user_path(@first_user)
    end

    it 'I can see the user\'s profile picture.' do
      expect(page).to have_css("img[src='https://unsplash.com/photos']")
    end

    it 'I can see the user\'s username.' do
      expect(page).to have_content(@first_user.name)
    end
    it 'I can see the number of post\'s the user has written.' do
      expect(page).to have_content(@first_post.title)
    end
    it 'I can see the user\'s bio.' do
      expect(page).to have_content(@first_user.bio)
    end
    it 'I can see the user\'s first 3 post\'s.' do
      expect(page).to have_content('first')
      expect(page).to have_content('This is my first post')
      expect(page).to have_content('second')
      expect(page).to have_content('This is my second post')
      expect(page).to have_content('third')
      expect(page).to have_content('This is my third post')
    end
    it 'I can see a button that lets me view all of a user\'s post\'s.' do
      expect(page).to have_link('See all posts')
    end
    it 'When I click a user\'s post, it redirects me to that post\'s show page.' do
      click_link('first')
      expect(page).to have_current_path(user_post_path(@first_user, @first_post))
    end
    it 'When I click to see all post\'s, it redirects me to the user\'s post\'s index page.' do
      click_link('See all posts')
      expect(page).to have_current_path(user_posts_path(@first_user))
    end
  end
end
