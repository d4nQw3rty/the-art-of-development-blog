require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    User.create(id: 1, name: 'Name', photo: 'Photo', bio: 'Bio')
  end

  before { subject.save }

  describe 'Validations' do
    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'post_counter have to be bigger than 0' do
      subject.posts_counter = -1
      expect(subject).to_not be_valid
    end

    it 'post_counter have to be greater or iqual to zero' do
      subject.posts_counter = 0
      expect(subject).to be_valid
    end

    it 'latest_posts method should return the last 3 posts' do
      4.times { Post.create(title: 'Title', text: 'Text', author_id: subject.id) }
      expect(subject.latest_posts.count).to eq(3)
    end
  end
end
