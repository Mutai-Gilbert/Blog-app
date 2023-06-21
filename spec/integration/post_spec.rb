require 'rails_helper'

RSpec.describe Post, type: :system do
  describe 'Post index page' do
    before do
      @user = User.create(name: 'Gilbert', photo: 'https://unsplash.com/photos', bio: 'A developer from Kenya.')
      @first_post = Post.create(author_id: @user.id, title: 'First post', text: 'First post')
      @comment = Comment.create(author: @user, post: @first_post, text: 'This is my comment')
      Like.create(author: @user, post: @first_post)
      visit user_posts_path(@user)
    end

    it 'I can see the users profile picture.' do
      expect(page).to have_css("img[src='https://unsplash.com/photos']")
    end
    it 'I can see the users username.' do
      expect(page).to have_content(@user.name)
    end
    it 'I can see the number of posts the user has written.' do
      expect(page).to have_content(@first_post.title)
    end
    it 'I can see a posts title.' do
      expect(page).to have_content(@first_post.title)
    end
    it 'I can see some of the posts body.' do
      expect(page).to have_content(@first_post.text)
    end
    it 'I can see the first comments on a post.' do
      expect(page).to have_content("by #{@user.name}")
    end
    it 'I can see how many comments a post has.' do
      expect(page).to have_content(@first_post.comments_counter)
    end
    it 'I can see how many likes a post has.' do
      expect(page).to have_content(@first_post.likes_counter)
    end
    it 'I can see a section for pagination if there are more posts than fit on the view.' do
      expect(page).to have_content('Pagination')
    end
    it 'When I click on a post, it redirects me to that posts show page.' do
      click_link('First post')
      expect(page).to have_current_path(user_post_path(@user, @first_post))
    end
  end
end
