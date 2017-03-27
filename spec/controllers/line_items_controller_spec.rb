require 'rails_helper'

RSpec.describe LineItemsController, type: :controller do

  let(:cart) { build :cart }
  let(:book) { build :product }
  let(:line_item) { create :line_item, book: book, cart: cart }

  describe 'POST #create' do
    let(:line_items_params) { attributes_for(:line_item).stringify_keys }
    before do
      @request.env['HTTP_REFERER'] = "#{book_url(line_item.product_id)}" 
      allow_any_instance_of(LineItem).to receive(:save) { true } 
    end

    context 'with valid attributes' do
      it 'receives save for order item' do
        expect_any_instance_of(LineItem).to receive(:save)
        post :create, params: { id: line_item.id, line_item: order_items_params }
      end

      it 'redirects to cart path if item was saved' do
        post :create, params: { id: line_item.id, line_item: order_items_params }
        expect(response).to redirect_to :back
      end

      it 'sends notice' do
        post :create, params: { id: line_item.id, line_item: order_items_params }
        expect(flash[:notice]).to eq I18n.t('order_item.create.success')
      end
    end

    context 'with invalid attributes' do
      before do
        allow_any_instance_of(LineItem).to receive(:save) { false }
        @request.env['HTTP_REFERER'] = "#{book_url(line_item.product_id)}"
      end

      it 'redirects to book path if item was not saved' do
        post :create, params: { id: oline_item.id, line_item: order_items_params }
        expect(response).to redirect_to :back
      end

      it 'sends alert' do
        post :create, params: { id: line_item.id, line_item: order_items_params }
        expect(flash[:alert]).to eq I18n.t('line_item.create.failure')
      end
    end

    context 'with forbidden attributes' do
      it 'generates ParameterMissing error without order item params' do
        expect { post :create, params: { id: line_item.id } }.to raise_error(ActionController::ParameterMissing)
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      allow(LineItem).to receive(:find).and_return line_item
      allow_any_instance_of(LineItem).to receive(:destroy) {}
    end

    it 'receives find and return order item' do
      expect(LineItem).to receive(:find).with(line_item.id.to_s)
      delete :destroy, params: { id: line_item }
    end

    it 'receives destroy for line_item' do
      expect(line_item).to receive(:destroy)
      delete :destroy, params: { id: line_item }
    end

    context 'cart has no items' do
      before do
        allow_any_instance_of(Cart).to receive(:has_items?) { false }
        delete :destroy, params: { id: line_item.id }
      end

      it 'redirects to the catalog page' do
        expect(response).to redirect_to category_path(:all)
      end

      it 'sends appropriate notice' do
        expect(flash[:notice]).to eq I18n.t('line_item.destroy.empty_cart')
      end
    end

    context 'cart still has few items' do
      before do
        allow_any_instance_of(Cart).to receive(:has_items?){ true }
        delete :destroy, params: { id: line_item.id }
      end

      it 'redirects to the cart page' do
        expect(response).to redirect_to cart_path
      end

      it 'sends appropriate notice' do
        expect(flash[:notice]).to eq I18n.t('line_item.destroy.non_empty_cart')
      end
    end
  end
end
