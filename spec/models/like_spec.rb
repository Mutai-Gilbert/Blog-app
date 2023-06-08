require 'rails_helper'

describe Like, type: :model do
  let(:test_user) { User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.', post_counter: 0) }
  let(:test_post) do
    Post.create(author: test_user, title: 'Hello', text: 'This is my first post', comments_counter: 0, likes_counter: 0)
  end
  let(:test_like) { Like.new(post: test_post, author: test_user) }

  before do
    test_like.author_id = test_user.id
    test_like.save
  end

  it 'should increment post like counter by 1' do
    expect(test_post.likes_counter).to eq(1)
  end

  it 'should have an author' do
    expect(test_like.author).to eq test_user
  end

  it 'should have a post' do
    expect(test_like.post).to eq test_post
  end
end
