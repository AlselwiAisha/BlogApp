require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'Is valid with valid attributes' do
    user = User.create(name: 'Aisha Mh.', posts_counter: 0)
    post = user.posts.build(title: 'Post1', comments_counter: 0, likes_counter: 0)
    expect(post).to be_valid
  end

  it 'Title should be presence' do
    user = User.create(name: 'Hadeel', posts_counter: 0)
    post = user.posts.build(comments_counter: 0, likes_counter: 0)
    expect(post).to_not be_valid
  end

  it 'Title should not be too long' do
    user = User.create(name: 'Sama', posts_counter: 0)
    post = user.posts.build(title: 'a' * 255, comments_counter: 0, likes_counter: 0)
    expect(post).to_not be_valid
  end

  it 'comments_counter should be a negative' do
    user = User.create(name: 'Eve', posts_counter: 0)
    post = user.posts.build(title: 'Comments1', comments_counter: -1, likes_counter: 0)
    expect(post).to_not be_valid
  end

  it 'increments the user posts_counter after creation' do
    user = User.create(name: 'Sana', posts_counter: 0)
    user.posts.create(title: 'Post3', comments_counter: 0, likes_counter: 0)
    user.posts.create(title: 'Post4', comments_counter: 0, likes_counter: 0)
    user.reload
    expect(user.posts_counter).to eq(2)
  end

  it 'increments the posts_counter' do
    user = User.create(name: 'Aisha Mh.', posts_counter: 0)
    user.posts.create(title: 'Post5', comments_counter: 0, likes_counter: 0)
    initial_posts_counter = user.posts_counter
    user.reload # Refresh the author instance from the database
    expect(user.posts_counter).to eq(initial_posts_counter + 1)
  end

  it 'returns recent comments' do
    user = User.create(name: 'Hana', posts_counter: 0)
    post = Post.create(title: 'Post4', author_id: user.id, comments_counter: 0, likes_counter: 0)
    comment1 = Comment.create(user_id: user.id, post_id: post.id, text: 'Comment1')
    comment2 = Comment.create(user_id: user.id, post_id: post.id, text: 'Comment2', created_at: 1.day.ago)
    recent_comments = post.recent_comments

    expect(recent_comments).to eq([comment1, comment2])
  end
end
