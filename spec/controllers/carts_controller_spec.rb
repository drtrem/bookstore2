require 'rails_helper'

RSpec.describe CartsController, type: :controller do

  let(:cart) { create :cart }

  describe "GET #show" do

    before do
      get :show
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders :show template' do
      expect(response).to render_template(:show)
    end
  end

  describe "GET #edit" do

    before do
      get :edit, params: { id: 1}
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders :show template' do
      expect(response).to render_template(:show)
    end
  end

  describe "GET #cupon_apply" do

    before do
      create :cupon
      get :cupon_apply, params: { id: 1, cupon: :cupon, number: 1111 }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders :show template' do
      expect(response).to render_template(:show)
    end
  end

  describe "invalid_cartst" do

    before do
      get :edit, params: { id: cart.id } 
    end

    it 'invalid_carts error' do
      expect(response).to have_http_status(302)
    end

    it 'redirect_to home' do
      expect(response).to redirect_to("http://test.host/en")
    end

    it "notice: 'Invalid cart'" do    
      expect(flash[:notice]).to be_present
    end
  end
end
