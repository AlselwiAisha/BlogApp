require 'rails_helper'

RSpec.describe 'Posts', type: :feature do
  before(:each) do
    @user = User.create(name: 'user1', photo: 'userPoto', bio: 'test_bio1', posts_counter: 1)
    @post = Post.create(title: 'post1', text: 'text', author_id: @user.id, comments_counter: 3, likes_counter: 1)
    @comment1 = Comment.create(text: 'this a comment1', user_id: @user.id, post_id: @post.id)
    @comment2 = Comment.create(text: 'this a comment2', user_id: @user.id, post_id: @post.id)
    @comment3 = Comment.create(text: 'this a comment3', user_id: @user.id, post_id: @post.id)
    @like = Like.create(user_id: @user.id, post_id: @post.id)

    visit user_post_path(@user, @post)
  end

  describe 'Post/index' do
    it 'See who wrote the post' do
      expect(page).to have_content(@user.name)
    end

    it 'The number of posts the user has written.' do
      expect(page).to have_content(@user.posts_counter)
    end

    it 'See a post title.' do
      expect(page).to have_content(@post.title)
    end

    it 'See some of the post body.' do
      expect(page).to have_content(@post.text)
    end

    it 'See the first comments of post.' do
      expect(page).to have_content('this a comment1')
    end

    it 'See the comments of the post.' do
      expect(page).to have_content('this a comment1')
      expect(page).to have_content('this a comment2')
      expect(page).to have_content('this a comment3')
    end

    it 'See how many comments a post has.' do
      expect(page).to have_content(@post.comments_counter)
    end

    it 'See how many likes a post has.' do
      expect(page).to have_content(@post.likes_counter)
    end

    it 'See the username of each commentor' do
        expect(page).to have_content(@comment1.user.name)
        expect(page).to have_content(@comment2.user.name)
      end
  
      it 'See the comment each commentor left' do
        expect(page).to have_content(@comment1.text)
        expect(page).to have_content(@comment2.text)
      end
  end
end
