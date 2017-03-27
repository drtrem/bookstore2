
require 'rails_helper'

RSpec.describe Cart, type: :model do
  let(:cart) { build :cart }

  describe 'instance methods' do
    let(:cart) { create :cart, coupon: '12345' }

    describe '#has_items?' do
      it 'returns true if cart has any items' do
        expect(cart).to have_items
      end

      it 'returns false if cart does not have any items' do
        allow(cart).to receive(:order_items).and_return []
        expect(cart).not_to have_items
      end
    end

    describe '#order_items_subtotal' do
      it 'returns overall order items subtotal(purchase price)' do
        # By default we are creating 10 order items.
        # So overall items subtotal must be 10 * 20 = 200
        cart.order_items.each do |item|
          allow(item).to receive(:subtotal).and_return 20.00
        end
        expect(cart.order_items_subtotal).to eq 200.00
      end
    end

    describe '#coupon_discount' do
      context 'when coupon is present' do
        it 'should invoke calculate_discount method' do
          expect(cart).to receive(:calculate_discount)
          cart.coupon_discount
        end
      end

      context 'when coupon is absent' do
        it 'just returns zero' do
          allow(cart).to receive(:coupon?).and_return false
          expect(cart).not_to receive(:calculate_discount)
          cart.coupon_discount
          expect(cart.coupon_discount).to eq 0.0
        end
      end
    end

    describe '#discount_percent' do
      context 'when the purchase price >= 1€ and <= 50€' do
        it 'returns 5% discount' do
          allow(cart).to receive(:order_items_subtotal).and_return 25.5
          expect(cart.discount_percent).to eq 5.0
        end
      end

      context 'when the purchase price >= 51€ and <= 100€' do
        it 'returns 10% discount' do
          allow(cart).to receive(:order_items_subtotal).and_return 83.50
          expect(cart.discount_percent).to eq 10.0
        end
      end

      context 'when the purchase price >= 101€ and <= 150€' do
        it 'returns 15% discount' do
          allow(cart).to receive(:order_items_subtotal).and_return 125.84
          expect(cart.discount_percent).to eq 15.0
        end
      end

      context 'when the purchase price >= 151€ and <= 200€' do
        it 'returns 20% discount' do
          allow(cart).to receive(:order_items_subtotal).and_return 181.32
          expect(cart.discount_percent).to eq 20.0
        end
      end

      context 'when the purchase price greater or equal 200€' do
        it 'returns 25% discount' do
          allow(cart).to receive(:order_items_subtotal).and_return 242.79
          expect(cart.discount_percent).to eq 25.0
        end
      end
    end

    describe "#calculate_discount" do
      it 'returns discount amount for current cart' do
        allow(cart).to receive(:order_items_subtotal).and_return 114.00
        allow(cart).to receive(:discount_percent).and_return 15.0
        result = 114.00 * (15.0 / 100.0)
        expect(cart.send(:calculate_discount)).to eq result
      end
    end

    describe '#total' do
      it 'returns total fee for current order' do
        allow(cart).to receive(:order_items_subtotal).and_return 98.50
        allow(cart).to receive(:coupon_discount).and_return 16.25
        expect(cart.total).to eq 82.25
      end
    end
  end

  describe 'associations' do
    it { expect(cart).to have_many :order_items }
  end
end