require 'rails_helper'
RSpec.describe 'Posts Show', type: :system do
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
      
      it 'displays post title' do #1
        visit user_post_path(@user, @post)
        expect(page).to have_content('First Step')
      end

      it 'displays post author' do #2
        visit user_post_path(@user, @post)
        expect(page).to have_content('Kanza Tehreen')
      end

      it 'displays the  comments counters' do #3
        visit user_post_path(@user, @post)
        expect(page).to have_content('Comments: 3')       
      end

      it 'displays the likes counter' do #4
        visit user_post_path(@user, @post)
        expect(page).to have_content('Likes: 1')
      end

      it 'displays the posts body' do #5
        visit user_post_path(@user, @post)
        expect(page).to have_content('This is my first post')
      end

      it 'displays the the username of each commentor' do #6
        visit user_post_path(@user, @post)
        expect(page).to have_content('Kanza Tehreen')
        expect(page).to have_content('Camilo Vela')
      end
    
      it 'displays all comments each commentor left' do #7
        visit user_post_path(@user, @post)
        expect(page).to have_content('A lot of people are hungry')
        expect(page).to have_content('Nothing is impossible')
        expect(page).to have_content('Can you help me?')
      end
    end
  end
end
