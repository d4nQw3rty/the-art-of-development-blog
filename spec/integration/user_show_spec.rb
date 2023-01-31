require 'rails_helper'

RSpec.describe 'User show page', type: :system do
  before :each do
    @user = User.create(name: 'Kanza', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Best friends', posts_counter: 12)
    @post = Post.create(title: 'Physics', text: 'This is not my first post', comments_counter: 10, likes_counter: 10, author: @user)
  end

  describe 'User show page' do
    before(:each) { visit user_path(@user) }

    it 'shows the profile picture for each user' do
      expect(page.has_xpath?("//img[@src = '#{@user.photo}' ]"))
    end

    it 'shows username for each users' do
      expect(page).to have_content(@user.name)
    end

    it "shows the number of posts the user" do
      expect(page).to have_content("Number of Posts: #{@user.posts_counter}")
    end

    it "displays the user's bio" do
      expect(page).to have_content(@user.bio)
    end

    it "displays the first 3 posts of the user" do
      @user.latest_posts.each do |post|
        expect(page).to have_content(post.title)
        expect(page).to have_content(post.text)
      end
    end

    it "displays the 'See all posts' button" do
      expect(page).to have_link('See all posts', href: user_posts_path(@user))
    end

    it "redirects to the post show page" do
      first_post = @user.latest_posts.first
      click_link(first_post.title)
      expect(page).to have_current_path(user_post_path(@user, first_post))
    end

    it 'redirects to show all posts of a user' do
      click_link("See all posts")
      expect(page).to have_current_path(user_posts_path(@user))
    end
  end
end

