class DeliveryController < ApplicationController
  before_filter :authenticate_user!
  skip_load_and_authorize_resource

  def index; end

  def create
    if session[:return_to].nil?
      session[:delivery_id] = params[:user][:id]
      redirect_to payment_index_path
    else
      session[:delivery_id] = params[:user][:id]
      @order = Order.find(session[:order_id])
      @delivery = Delivery.find(@order.delivery_id)
      render 'confirm/index'
    end
  end 
end 
