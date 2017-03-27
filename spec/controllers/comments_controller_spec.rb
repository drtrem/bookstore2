require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:book) { build :product } 
  let(:user) { build :user }
  let(:review) { create :comment }  

  describe "POST #create" do
    let(:review_params) { attributes_for(:comment).stringify_keys }

    before do
      @request.env['HTTP_REFERER'] = "#{book_url(review)}"
      allow_any_instance_of(Comment).to receive(:save) { true }
    end

    context 'with valid attributes' do
      it 'receives save for review' do
        expect_any_instance_of(Comment).to receive(:save)
        post :create, params: { product_id: review.product_id, comment: review_params }
        expect(response).to redirect_to book_path(1)
      end

      it 'redirects to book path if review was saved' do
        post :create, params: { product_id: review.product_id, comment: review_params }
        expect(response).to redirect_to book_path(1)
      end
    end

    context 'with invalid attributes' do
      before do
        allow_any_instance_of(Comment).to receive(:save) { false }
      end

      it 'redirects to book path if item was not saved' do
        post :create, params: { product_id: review.product_id, comment: review_params }
        expect(response).to redirect_to book_path(1)
      end
    end
  end
end