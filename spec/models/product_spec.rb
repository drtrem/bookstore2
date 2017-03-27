require 'rails_helper'

RSpec.describe Book, type: :model do
  let(:book) { build :book }

  describe 'validations' do
    context 'not valid attributes' do
      describe 'title' do
        it { expect(book).to validate_presence_of(:title)}
        it { expect(book).to validate_length_of(:title).is_at_least(6).is_at_most(80) }
        it { expect(book).to validate_uniqueness_of(:title)}
      end

      describe 'description' do
        it { expect(book).to validate_presence_of(:description) }
        it { expect(book).to validate_length_of(:description).is_at_least(10).is_at_most(1000) }
      end

      describe 'price' do
        it { expect(book).to validate_numericality_of(:price).is_greater_than_or_equal_to(0.1) }
      end

      describe 'available_in_stock' do
        it do
          expect(book).to validate_numericality_of(:available_in_stock)
                      .only_integer.is_greater_than_or_equal_to(0)
        end
      end

      describe 'year_of_publication' do
        it do
          expect(book).to validate_numericality_of(:year_of_publication).only_integer
                      .is_greater_than_or_equal_to(1990)
                      .is_less_than_or_equal_to(Time.now.year)
        end
      end

      describe 'materials' do
        it { expect(book).to validate_presence_of(:materials) }
      end

      describe 'image' do
        it { expect(book).to validate_presence_of(:image) }
      end

      describe 'dimensions' do
        it { expect(book).to validate_numericality_of(:height).is_greater_than_or_equal_to(5.0) }
        it { expect(book).to validate_numericality_of(:width).is_greater_than_or_equal_to(3.0) }
        it { expect(book).to validate_numericality_of(:depth).is_greater_than_or_equal_to(0.1) }
      end
    end

    context 'valid attributes' do
      it { expect(book).to be_valid }
    end
  end

  describe 'scopes' do
    let(:category) { build :category }

    before do
      create_list :book, 3, category: category
    end

    describe '.total_in_stock' do
      it 'return available books quantity' do
        expect(Book.total_in_stock).to eq 225 # default value for each book is 75
      end
    end

    %w(created_at price title).each do |scope|
      describe ".by_#{scope}" do
        it "returns books ordered by #{scope}, ascending" do
          expect(Book.send("order", {"#{scope}": :asc}) ).to match_array Book.all.order("#{scope} ASC")
        end

        it "returns books ordered by #{scope}, descending" do
          expect(Book.send("order", {"#{scope}": :desc}) ).to match_array Book.all.order("#{scope} DESC")
        end
      end
    end
  end

  describe 'associations' do
    it { expect(book).to belong_to(:category) }
    it { expect(book).to have_and_belong_to_many(:authors) }
    it { expect(book).to have_many(:order_items) }
    it { expect(book).to have_many(:pictures) }
    it { expect(book).to have_many(:reviews) }
  end
end