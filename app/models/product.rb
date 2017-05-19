class Product < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :line_items
  has_many :orders, through: :line_items
  belongs_to :author
  belongs_to :category
  
  before_destroy :ensure_not_referenced_by_any_line_item

  mount_uploader :image_url, PictureUploader

  def self.latest
    Product.order(:updated_at).last
  end

  private

  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      true
    else
      errors.add(:base, 'There are headings')
      false
    end
  end
end
