class OrdersController < InheritedResources::Base
  include CurrentCart
  include OrdersHelper

  before_action :set_cart, only: [:index, :create]
  before_action :authenticate_user!

  def index
    @user = User.find(current_user.id)
    if @cart.line_items.empty?
      redirect_to store_url, notice: "Your cart is empty"
      return
    end
  end

  def create
    @user = User.find_by_id(current_user.id)
    if session[:return_to] == nil
      if @user.update_attributes(user_params)
        render 'delivery/index'
      else
        render 'orders/index'
      end
    else
      @order = Order.find(session[:order_id])
      @delivery = Delivery.find(@order.delivery_id)
      if @user.update_attributes(user_params)
        render 'confirm/index'
      else
        render 'orders/index'
      end
    end
    copy_params if @user.check == true
    @user.save 
  end

  private

  def user_params
    if params[:check] == 'true'
      @user.check = true
      @user.save(validate: false)
      params.require(:user).permit(:first_name, :last_name, :address, :city, :zip, :country, :phone)
    else
      @user.check = false
      @user.save(validate: false)
      params.require(:user).permit(:first_name, :last_name, :address, :city, :zip, :country, :phone, :shipping_first_name, :shipping_last_name, :shipping_address, :shipping_city, :shipping_zip, :shipping_country, :shipping_phone)
    end
  end
end