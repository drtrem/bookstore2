require 'rails_helper'

RSpec.describe Coupon, type: :model do
  let(:coupon) { build :coupon }

  describe 'validations' do
    context 'invalid attributes' do
      it { expect(coupon).to validate_presence_of(:value) }
    end

    context 'valid attributes' do
      it { expect(coupon).to be_valid }
    end
  end
end