require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe 'GET #show' do
    before do
      @category = create(:category)
      get :show, params: { id: @category }
    end

    it "saves location" do
      expect(session[:forwarding_url]).to eq(product_path)
    end

    it "assigns the requested category to @category" do
      expect(assigns(:category)).to eq @category.id
    end

    it "assigns the requested category books to @sorted_books" do
      expect(assigns(:sorted_books)).to eq @category.id
    end

    it "@sorted_book should be decorated" do
      expect(assigns(:sorted_books)).to eq(1)
    end

    it "renders the :show template" do
      expect(response).to render_template :show
    end
  end
end