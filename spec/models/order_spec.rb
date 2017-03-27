  require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order) { build :order}

  describe 'associations' do
    it { expect(order).to belong_to(:user) }
    it { expect(order).to belong_to(:delivery) }
    it { expect(order).to belong_to(:credit_card) }
    it { expect(order).to have_one(:billing_address) }
    it { expect(order).to have_one(:shipping_address) }
    it { expect(order).to have_many(:order_items) }
  end

  describe 'scopes' do
    describe '.with_state' do
      it 'returns orders with appropriate state' do
        not_confirmed_orders = create_list :order, 5, state: 'not_confirmed'
        waiting_for_processing_orders = create_list :order, 5, state: 'waiting_for_processing'
        in_progress_orders = create_list :order, 5, state: 'in_progress'

        expect(Order.with_state('not_confirmed')).to eq not_confirmed_orders
        expect(Order.with_state('waiting_for_processing')).to eq waiting_for_processing_orders
        expect(Order.with_state(:in_progress)).to eq in_progress_orders
      end
    end

    describe '.generate_invoice' do
      it 'generates orders number(invoice) based on timestamp' do
        allow(Time).to receive_message_chain(:now, :to_s) { "2017-03-11 19:26:22 +0200" }
        invoice = Order.generate_invoice
        expect(invoice).to eq 'R#20170311192622'
      end
    end
  end

  describe 'delegates' do
    it 'responds to delegatable address methods' do
      methods = %i{ bill_first_name bill_last_name bill_address bill_city bill_country bill_zip bill_phone
                    ship_first_name ship_last_name ship_address ship_city ship_country ship_zip ship_phone }
      expect(order).to respond_to(*methods)
    end
    
    it 'responds to delegatable credit card methods' do
      methods = %i{card_number card_name card_expiration_date card_cvv}
      expect(order).to respond_to(*methods)
    end
  end
  
  describe 'states' do
    describe 'responding to methods, provided by AASM' do
      context 'instance methods' do
        it do
          instance_methods = %i{ not_confirmed? waiting_for_processing? in_progress? in_delivery? delivered? }
          expect(order).to respond_to(*instance_methods)
        end
      end

      context 'class methods' do
        it do
          class_methods = %i{ not_confirmed waiting_for_processing in_progress in_delivery delivered }
          expect(Order).to respond_to(*class_methods)
        end
      end
    end

    describe '#confirm!' do
      it 'changes order state from :not_confirmed to :waiting_for_processing' do
        expect { order.confirm! }.to change { order.state }.from('not_confirmed').to('waiting_for_processing')
      end
    end
  end
end
