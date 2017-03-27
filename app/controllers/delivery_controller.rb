class DeliveryController < ApplicationController

  before_action :authenticate_user!

  def index
  end

  def create
    if params[:user] == nil
      render 'delivery/index' 
      return
    end
    if session[:return_to] == nil
      session[:delivery_id] = params[:user][:id]
      redirect_to payment_index_path
    else
      session[:return_to] = nil
      session[:delivery_id] = params[:user][:id]
      @order = Order.find(session[:order_id])
      @delivery = Delivery.find(@order.delivery_id)
      session[:return_to] = true
      render 'confirm/index'
    end
  end
end
