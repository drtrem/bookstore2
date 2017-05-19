class ConfirmController < ApplicationController
  include CurrentCart

  before_action :authenticate_user!

  def index
  	set_cart
    session[:return_to] = true
    @order = Order.find(session[:order_id])
    @delivery = Delivery.find(@order.delivery_id)
    render 'confirm/index'
  end
end
