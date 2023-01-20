require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject do
    Comment.create(id: 1, text: 'Text', post_id: 1, author_id: 1)
  end

  before { subject.save }

  describe 'Validations' do
    it 'is not valid without text' do
      subject.text = nil
      expect(subject).to_not be_valid
    end
  end
end
