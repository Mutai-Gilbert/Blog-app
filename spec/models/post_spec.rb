require 'rails_helper'

describe Post, type: :model do
  test_user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.',
                          post_counter: 0)
  test_post = Post.create(author: test_user, title: 'Hello', text: 'This is my first post', comments_counter: 0,
                          likes_counter: 0)

  before { test_post.save }
  it 'should have a title' do
    expect(test_post.title).to eq 'Hello'
  end

  it 'validates the length of title is at most 250 characters' do
    test_post.title = 'a' * 251
    expect(test_post).to_not be_valid
    test_post.title = 'a' * 250
    expect(test_post).to be_valid
  end

  it 'should have a text' do
    expect(test_post.text).to eq 'This is my first post'
  end

  it 'should have an author' do
    expect(test_post.author).to eq test_user
  end

  it 'comment counter should be an integer' do
    subject.comments_counter = 2.5
    expect(subject).to_not be_valid
  end
  it 'like counter should be an integer' do
    subject.likes_counter = 2.5
    expect(subject).to_not be_valid
  end
  it 'comment counter should be greater than zero' do
    subject.comments_counter = -2
    expect(subject).to_not be_valid
  end
  it 'like counter should be greater than zero' do
    subject.comments_counter = -2
    expect(subject).to_not be_valid
  end
  it 'increments the post_counter by 1' do
    expect(test_user.post_counter).to eq 1
  end

  it 'post should return top 5 comments' do
    test_post = Post.create(author: test_user, title: 'Hello', text: 'This is my first post', comments_counter: 0,
                            likes_counter: 0)
    Comment.create(post: test_post, author: test_user, text: 'This is my first comment')
    Comment.create(post: test_post, author: test_user, text: 'This is my second comment')
    Comment.create(post: test_post, author: test_user, text: 'This is my third comment')
    Comment.create(post: test_post, author: test_user, text: 'This is my fourth comment')
    Comment.create(post: test_post, author: test_user, text: 'This is my fifth comment')
    expect(test_post.top_5_comment.size).to eq(5)
  end
end
