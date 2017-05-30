class ConfirmController < ApplicationController
  include CurrentCart

  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
  	set_cart
    session[:return_to] = true
    @order = Order.find(session[:order_id])
    @delivery = Delivery.find(@order.delivery_id)
    render 'confirm/index'
  end
end
