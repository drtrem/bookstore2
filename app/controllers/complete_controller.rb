class CompleteController < ApplicationController
  include CurrentCart

  before_action :authenticate_user!

  before_action :authenticate_user!
  before_action :set_cart, only: [:index]
  after_action :clear_line_items, only: [:index]
  after_action :clear, only: [:index]

  def index
    @order = Order.find(session[:order_id])
    @delivery = Delivery.find(@order.delivery_id)
    @item = LineItem.where(order_id: session[:order_id])
    render 'complete/index'
  end

  def clear
    Cart.destroy(session[:cart_id])
    session[:cart_id] = nil
    session[:order_id] = nil
    session[:return_to] = nil
  end
end
