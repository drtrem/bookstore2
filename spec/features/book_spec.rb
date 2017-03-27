require 'rails_helper'


feature 'Book', type: :feature, js: true do
  let!(:mobile) { create :category, category: 'Mobile Development' }
  let!(:mobile_book) { create(:product) }
  let!(:user) { create :user }
  let!(:review) { create :comment }

  before do
    expect_any_instance_of(Product).to receive(:views).and_return(1)
  end

  background do
    visit book_path(id: mobile_book.id)
  end

  context 'main book page' do
    scenario 'main elements' do
      expect(page).to have_content('Back to results')
      expect(first('input.btn-default').value).to eq('Add to Cart')
    end

    scenario 'book params' do
      expect(page).to have_content(mobile_book.title)
      expect(page).to have_content(mobile_book.year)
      expect(page).to have_content(mobile_book.price)
    end

    scenario 'book description' do
      expect(page).to have_content(mobile_book.description[0...247] << '...')
      find('.read-more').click
      expect(page).to have_content(mobile_book.description)
    end
  end
end 