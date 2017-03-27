class ConfirmController < ApplicationController
  include CurrentCart

  before_action :authenticate_user!
  before_action :set_cart, only: [:index]

  def index
    session[:return_to] = true
    @order = Order.find(session[:order_id])
    @delivery = Delivery.find(@order.delivery_id)
    render 'confirm/index'
  end
end
