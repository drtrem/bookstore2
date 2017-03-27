require 'rails_helper'

RSpec.feature 'Show books', type: :feature, js: true do
  let(:category) { create(:category) }
  let(:product) { create(:product) }
  let(:slide){ create(:product) }

  background do
    visit store_path
  end

  context 'main elements' do
    scenario 'main elements' do
      allow_any_instance_of(Product).to receive(:image_url).and_return("Wibble")
      expect(page).to have_content(I18n.t('general.project_name'))
      expect(page).to have_content(I18n.t('general.welcome'))
      expect(page).to have_content(I18n.t('layout.links.home'))
      expect(page).to have_content(I18n.t('layout.links.shop'))
      expect(page).to have_css '.shop-icon'
    end
  end

  context 'different headers for' do
    scenario 'guests' do
      expect(page).to have_content(I18n.t('layout.links.signup'))
      expect(page).to have_content(I18n.t('layout.links.login'))
    end

    scenario 'users' do
      sign_in(create :user)
      expect(page).to have_content(I18n.t('layout.links.profile'))
    end
  end

  context 'books are displayed on page' do
    scenario 'slider show' do
      expect(page).to have_selector('h1', text: book_mobile_second.name)
      find('a.right.carousel-control').click
      expect(page).to have_selector('h1', text: book_mobile_first.name)
    end
    scenario 'bestsellers' do
      expect(page).to have_selector('.title', text: book_mobile_first.name)
      expect(page).to have_selector('.title', text: book_mobile_second.name)
      expect(page).to have_selector('p.pull-right', text: book_mobile_second.price)
    end
  end
end
