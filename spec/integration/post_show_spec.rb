require 'rails_helper'
RSpec.describe 'Posts Show', type: :feature do
  describe 'post show page' do
    before(:each) do
      @user = User.create(
        name: 'Kanza Tehreen',
        bio: 'Full Stack Web Developer',
        photo: 'https://avatars.kanzatehreen.com',
        posts_counter: 0
      )

      @user1 = User.create(
        name: 'Camilo Vela',
        bio: 'Web Developer',
        photo: '',
        posts_counter: 5
      )

      @post = Post.create(
        author_id: @user.id,
        title: 'First Step',
        text: 'This is my first post',
        comments_counter: 0,
        likes_counter: 0
      )

      Comment.create(post_id: @post.id, author_id: @user.id, text: 'A lot of people are hungry')
      Comment.create(post_id: @post.id, author_id: @user.id, text: 'Nothing is impossible')
      Comment.create(post_id: @post.id, author_id: @user1.id, text: 'Can you help me?')
      Like.create(post_id: @post.id, author_id: @user1.id)
    end

    describe 'Displays the entire body comments counters, and title' do
      it 'displays the counters' do
        visit user_post_path(@user, @post)
        expect(page).to have_content('Comments: 3')
        expect(page).to have_content('Likes: 1')
      end

      it 'displays post title' do
        visit user_post_path(@user, @post)
        expect(page).to have_content('First Step')
      end

      it 'displays post by author as the title' do
        visit user_post_path(@user, @post)
        expect(page).to have_content('First Step by Kanza Tehreen')
      end

      it 'displays the posts content' do
        visit user_post_path(@user, @post)
        expect(page).to have_content('This is my first post')
      end

      it 'checks there is a comment section' do
        visit user_post_path(@user, @post)
        expect(page).to have_css("ul[class*='post_list comments_box_border']")
        expect(page).to have_content('Comments')
      end

      it 'displays all comments with usernames' do
        visit user_post_path(@user, @post)
        expect(page).to have_content('Kanza Tehreen: A lot of people are hungry')
        expect(page).to have_content('Kanza Tehreen: Nothing is impossible')
        expect(page).to have_content('Camilo Vela: Can you help me?')
      end
    end
  end
end
