require 'rails_helper'

RSpec.describe 'Posts', type: :feature do
  before(:each) do
    @user =  User.create(name: 'user1',photo: 'userPoto', bio: 'test_bio1', posts_counter: 1)
    @post = Post.create(title: 'post1', text: 'text', author_id: @user.id, comments_counter: 1, likes_counter: 1)
    @comment1 = Comment.create(text: 'this a comment1', user_id: @user.id, post_id: @post.id)
    @comment2 = Comment.create(text: 'this a comment2', user_id: @user.id, post_id: @post.id)
    @comment3 = Comment.create(text: 'this a comment3', user_id: @user.id, post_id: @post.id)
    @like = Like.create(user_id: @user.id, post_id: @post.id)

    visit user_posts_path(@user)
  end

  describe 'Post/index' do
    it 'renders a list of posts' do
      expect(page).to have_selector('h1', text: "Here is a list of posts for #{@user.name}")
    end

    it 'User name.' do
      expect(page).to have_content(@user.name)
    end

    it 'The number of posts the user has written.' do
      expect(page).to have_content(@user.posts_counter)
    end

    it 'See a post title.' do
      expect(page).to have_content(@post.title)
    end

    it 'See some of the post text.' do
      expect(page).to have_content(@post.text)
    end

    it 'See the comments of post.' do
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

    it 'When I click on a post, it redirects me to that post show page.' do
      click_link(@post.title)
      expect(current_path).to match user_post_path(@user, @post)
    end
  end
end
