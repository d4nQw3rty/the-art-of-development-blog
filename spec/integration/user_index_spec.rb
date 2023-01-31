require 'rails_helper'

RSpec.describe 'User Index', type: :system do
  describe ' user index page' do
    before(:each) do
      @user = User.create(
        name: 'Kanza Tehreen',
        bio: 'Full Stack Web Developer',
        photo: 'https://avatars.kanzatehreen.com',
        posts_counter: 1
      )

      @user2 = User.create(
        name: 'Camilo Vela',
        bio: 'Web Developer',
        photo: 'https://avatars.camilovela.com',
        posts_counter: 2
      )
    end

    it 'should display all users' do
      visit users_path
      expect(page).to have_content('Kanza Tehreen')
      expect(page).to have_content('Camilo Vela')
    end

    it 'shows the right photo' do
      visit users_path
      expect(page).to have_css("img[src*='https://avatars.kanzatehreen.com']")
      expect(page).to have_css("img[src*='https://avatars.camilovela.com']")
    end

    it 'displays the right Number of posts' do
      visit users_path
      expect(page).to have_content('Number of Posts: 1')
      expect(page).to have_content('Number of Posts: 2')
    end

    it 'redirected to show path' do
      visit users_path
      click_link 'Kanza Tehreen'
      expect(page).to have_content('Full Stack Web Developer')
    end

    it 'redirected to show path' do
      visit users_path
      click_link 'Camilo Vela'
      expect(page).to have_content('Web Developer')
    end
  end
end
