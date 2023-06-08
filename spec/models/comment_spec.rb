require 'rails_helper'

describe Comment, type: :model do
  let(:test_user) { User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.', post_counter: 0) }
  let(:test_post) do
    Post.create(author: test_user, title: 'Hello', text: 'This is my first post', comments_counter: 0, likes_counter: 0)
  end
  let(:test_comment) { Comment.new(post: test_post, author: test_user) }

  before { test_comment.save }

  it 'should increment user comment counter by 1' do
    expect(test_post.comments_counter).to eq(1)
  end
end
