require 'rails_helper'

RSpec.describe ViewOrdersController, type: :controller do
  let(:user) { create :user }
  let(:order) { create :order }
  login_user

  describe "GET #index" do

    before do
      get :index, params: { order_id: 1, cart_id: 1, return_to: 1 }
    end

    it "returns http success" do
      expect(response).to render_template(:index)
    end

    it 'has a 200 status code' do
      expect(response.status).to eq(200)
    end
  end
end
