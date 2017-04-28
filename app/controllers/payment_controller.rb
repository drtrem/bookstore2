require_dependency "app/services/payment_service.rb"
class PaymentController < ApplicationController
  include CurrentCart

  before_action :authenticate_user!
  before_action :set_cart, only: %i(index create)

  def index
    if session[:return_to].nil?
      @order = Order.new
      @order.delivery_id = session[:delivery_id]
      render 'payment/index'
    else
      session[:return_to] = true
      @order = Order.find_by_id(session[:order_id])
      render 'payment/index'
    end
  end

  def create
    @order = current_user.orders.build(order_params)
    @order.delivery_id = session[:delivery_id]
    @delivery = Delivery.find(@order.delivery_id)
    PaymentService.new(@order, @cart).create_order
    if session[:order_id].nil?
      if @order.save
        session[:order_id] = @order.id
        session[:return_to] = true
        render 'confirm/index'
      else
        render 'payment/index'
      end
    else
      @order = Order.find_by_id(session[:order_id])
      @order.update_attributes(order_params)
      render 'confirm/index'
    end
  end

  private

  def order_params
    params.permit(:card_number, :name_on_card, :mm_yy, :cvv)
  end
end
