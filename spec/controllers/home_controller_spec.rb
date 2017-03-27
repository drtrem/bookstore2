require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  let(:user) { create :user }
  let(:product) { create :product }
  login_user

  describe "GET #index" do
    before do
      get :index
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'has a 200 status code' do
      expect(response.status).to eq(200)
    end

    it 'renders :show template' do
      expect(response).to render_template(:index)
    end
  end

  describe "GET #create" do

    before do
      get :create, params: { product_id: 1}
    end

    it 'has a 200 status code' do
      expect(response.status).to eq(302)
    end
    
    it 'renders :show template' do
      expect(response).to redirect_to(home_index_path)
    end
  end
end  
