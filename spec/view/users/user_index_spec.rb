require 'rails_helper'

RSpec.describe 'Users', type: :feature do
  describe 'index page' do
    before(:example) do
      @user = User.create(name: 'Lucy', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Engineer',
                          posts_counter: 1)
      @user2 = User.create(name: 'user2', photo: 'photo2', bio: 'bio2', posts_counter: 0)
      visit users_path
    end

    it 'See username of all other users.' do
      User.all.each do |user|
        expect(page).to have_content(user.name)
      end
    end

    it "See the user's profile picture" do
      expect(page).to have_selector("//img[@src = '#{@user.photo}' ]")
      expect(page).to have_selector("img[src*='#{@user2.photo}']")
    end

    it 'See correct number of posts user has written' do
      User.all.each do |user|
        expect(page).to have_content(user.posts_counter)
      end
    end

    it "redirected to that user's show page after clicking on user" do
      click_link @user.name
      expect(page).to have_current_path(user_path(@user.id))
    end
  end
end
