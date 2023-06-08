require 'rails_helper'

describe User, type: :model do
  let(:test_user) { User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.', post_counter: 0) }

  before { test_user.save }

  it 'should have a name' do
    expect(test_user.name).to eq 'Tom'
  end

  it 'should have a photo' do
    expect(test_user.photo).to eq 'https://unsplash.com/photos/F_-0BxGuVvo'
  end

  it 'should have a bio' do
    expect(test_user.bio).to eq 'Teacher from Mexico.'
  end

  it 'should have a post counter' do
    expect(test_user.post_counter).to eq 0
  end

  it 'post counter should be an integer' do
    subject.post_counter = 2.5
    expect(subject).to_not be_valid
  end

  it 'post counter should be greater than zero' do
    subject.post_counter = -2
    expect(subject).to_not be_valid
  end

  it 'user should return top three posts' do
    User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.',
                post_counter: 0)
    Post.create(author: test_user, title: 'Hello', text: 'This is my first post', comments_counter: 0,
                likes_counter: 0)
    Post.create(author: test_user, title: 'Hello', text: 'This is my second post', comments_counter: 0,
                likes_counter: 0)
    Post.create(author: test_user, title: 'Hello', text: 'This is my third post', comments_counter: 0,
                likes_counter: 0)
    expect(test_user.top_3_posts.count).to eq(3)
  end
end
