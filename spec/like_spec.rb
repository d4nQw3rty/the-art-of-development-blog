require 'rails_helper'

RSpec.describe Like, type: :model do
  subject do
    Like.create(id: 1, post_id: 1, author_id: 1)
  end

  before { subject.save }

  describe 'Validations' do
    it 'is not valid without a post' do
      subject.post_id = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without an author' do
      subject.author_id = nil
      expect(subject).to_not be_valid
    end
  end
end
