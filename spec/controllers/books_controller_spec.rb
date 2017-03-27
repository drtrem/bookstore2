require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  let(:book) { create(:product) }

  describe 'show' do

    before do
      get :show, params: { id: book.id }
    end

    it 'renders :show template' do
      expect(response).to render_template(:show)
    end

    it 'has a 200 status code' do
      expect(response.status).to eq(200)
    end

    it 'right assigns' do
      expect(assigns(:product)).to eq(book) 
     end
  end
end
 