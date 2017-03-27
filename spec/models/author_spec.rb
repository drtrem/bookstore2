require 'rails_helper'

RSpec.describe Author, type: :model do
  let(:author) { build :author }

  describe 'validations' do
    context 'not valid attributes' do
      describe 'first_name' do
        it { expect(author).to validate_presence_of(:first_name) }
        it { expect(author).to validate_length_of(:first_name).is_at_least(2).is_at_most(40) }
        it { expect(author).to validate_uniqueness_of(:first_name).scoped_to(:last_name)   }
      end

      describe 'last_name' do
        it { expect(author).to validate_presence_of(:last_name) }
        it { expect(author).to validate_length_of(:last_name).is_at_least(3).is_at_most(50) }
      end

      describe 'bio' do
        it { expect(author).to validate_presence_of(:bio) }
        it { expect(author).to validate_length_of(:bio).is_at_most(1000)}
      end
    end

    context 'valid attributes' do
      it { expect(author).to be_valid }
    end
  end

  describe 'associations' do
    it { expect(author).to have_and_belong_to_many(:books) }
  end
end