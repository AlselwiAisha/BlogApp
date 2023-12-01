require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'after_create' do
    it 'increments post likes_counter' do
      user1 = User.create(name: 'Aisha', posts_counter: 0)
      user2 = User.create(name: 'Sana', posts_counter: 0)
      user1.save!
      user2.save!
      post = user1.posts.create(title: 'Post1', text: 'This is a post', likes_counter: 0, comments_counter: 0)
      post.likes.create(user_id: user1.id, post_id: post.id)
      post.likes.create(user_id: user2.id, post_id: post.id)
      expect(post.likes_counter).to eql(2)
    end
  end
end
