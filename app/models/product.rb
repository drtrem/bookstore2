class Product < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :line_items
  has_many :orders, through: :line_items
  belongs_to :author
  belongs_to :category
  
  before_destroy :ensure_not_referenced_by_any_line_item

  mount_uploader :image_url, PictureUploader

  scope :sort_column, ->(params) { Product.column_names.include?(params[:sort]) ? params[:sort] : 'created_at' }
  scope :sort_direction, ->(params) { %w(asc desc).include?(params[:direction]) ?  params[:direction] : 'desc' }
  scope :sort_product, ->(params, session) { order(sort_column(params) + ' ' + sort_direction(params)).where(category_id: session[:category]).page(params[:page]) }
  scope :sort_by_category, ->(params) { where(category_id: params[:id]).page(params[:page]) }
  scope :slide, -> { where(category_id: 2).take(2) }

  def self.latest
    Product.order(:updated_at).last
  end

  private

  def ensure_not_referenced_by_any_line_item
    return true if line_items.empty?
    errors.add(:base, 'There are headings')
    false
  end
end
