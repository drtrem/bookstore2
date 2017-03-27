require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:user) { create(:user, orders: [order]) }
  let(:order) { create(:order) }
  before { sign_in user } 

  describe 'GET #index' do
    before do
      allow(controller).to receive(:current_user).and_return(user)
      get :index
    end

    it "assigns the requested orders to @orders" do
      expect(assigns(:orders)).to eq user.orders
    end

    it "renders the :index template" do
      expect(response).to render_template :index
    end
  end

  describe 'GET #create' do
    before { get :create, params: { id: order.id } }

    it "assigns the requested order to @order" do
      expect(assigns(:order)).to eq order
    end

    it "renders the :show template" do
      expect(response).to render_template :show
    end
  end
end