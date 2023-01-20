require 'rails_helper'

RSpec.describe Post, type: :model do
  subject do
    Post.create(id: 1, title: 'Title', text: 'Text', author_id: 1)
  end

  before { subject.save }

  describe 'Validations' do
    it 'is not valid without a title' do
      subject.title = nil
      expect(subject).to_not be_valid
    end  

    it 'is not valid without text' do
      subject.text = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid with a title longer than 250 characters' do
      subject.title = 'a' * 251
      expect(subject).to_not be_valid
    end

    it 'is not valid with a negative comments counter' do
      subject.comments_counter = -1
      expect(subject).to_not be_valid
    end

    it 'is not valid with a negative likes counter' do
      subject.likes_counter = -1
      expect(subject).to_not be_valid
    end
  end  
end 

