class Order < ApplicationRecord
  include AASM
  attr_accessor :active_admin_requested_event

  has_many :line_items, dependent: :destroy
  belongs_to :user

  validates :card_number, :name_on_card, :mm_yy, :cvv, presence: true
  validates :card_number, length: { minimum: 10 }, format: { with: /\A[0-9]+\z/, message: 'please enter a valid credit card number' }
  validates :name_on_card, length: { maximum: 50 }, format: { with: /\A[a-zA-Z]+\z/, message: 'only allows letters' }
  validates :mm_yy, format: { with: /\A(0{1}([0-9]){1}|1{1}([0-2]){1})\/\d{2}\z/, message: 'the expiration date must be MM/YY' }
  validates :cvv, length: { maximum: 4 }

  scope :sort_order_all, ->(current_user, params) { order(id: :desc).where(user_id: current_user.id).where(state: params[:sort_order]) }
  scope :sort_order, ->(current_user) { order(id: :desc).all.where(user_id: current_user.id) }

  aasm column: 'state' do
    state :in_queued, initial: true
    state :in_delivering
    state :delivering
    state :canceling

    event :in_delivery do
      transitions from: :in_queued, to: :in_delivering
    end

    event :delivery do
      transitions from: :in_delivering, to: :delivering
    end

    event :cancel do
      transitions from: %i(in_queued in_delivering delivering), to: :canceling
    end
  end

  def add_line_items_from_cart(cart)
    line_items = cart.line_items.map(&:item)
  end

  def total_price
    line_items.to_a.sum(&:total_price)
  end

  def total_cupon
    cupon = Cupon.find(cupon_id)
    cupon.price
  end

  def total_delivery
    delivery = Delivery.find(delivery_id)
    delivery.price
  end
end
