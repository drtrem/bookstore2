class CompleteController < ApplicationController
  include CurrentCart
  include CompleteHelper

  before_filter :authenticate_user!
  skip_load_and_authorize_resource

  def index
    set_cart
    @order = Order.find(session[:order_id])
    @delivery = Delivery.find(@order.delivery_id)
    @item = LineItem.where(order_id: session[:order_id])
    render 'complete/index'
    clear_line_items
    clear_cart
  end
end
 