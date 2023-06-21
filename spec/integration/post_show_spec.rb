require 'rails_helper'

RSpec.describe Post, type: :system do
  describe 'Post show Page' do
    before do
      @user = User.create(name: 'Gilbert', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                          bio: 'A develoer from Kenya.', post_counter: 0)
      @first_post = Post.create(author_id: @user.id, title: 'My medium post', text: 'This is my first post',
                                comments_counter: 0, likes_counter: 0)
      @comment = Comment.create(author: @user, post: @first_post, text: 'This is my comment')
      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(User.create(name: 'Tom', photo: 'https://unsplash.com/photos', bio: 'Teacher from Mexico.',
                                post_counter: 0))
      Like.create(author: @user, post: @first_post)
      visit user_post_path(@user, @first_post)
    end
  end
end
