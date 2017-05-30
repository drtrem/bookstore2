class OrdersController < InheritedResources::Base
  include CurrentCart
  include OrdersHelper

  before_action :set_cart, only: %i(index create)
  before_action :find_user, only: %i(index create)
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    redirect_to store_url, notice: "Your cart is empty" unless @cart.line_items
  end

  def create
    if session[:return_to] == nil
      first_view_order
    else
      many_view_order
    end
    copy_params if @user.check == true
    @user.save 
  end

  private

  def first_view_order
    if @user.update_attributes(user_params)
      render 'delivery/index'
    else
      render 'orders/index'
    end
  end

  def many_view_order
    @order = Order.find(session[:order_id])
    @delivery = Delivery.find(@order.delivery_id)
    if @user.update_attributes(user_params)
      render 'confirm/index'
    else
      render 'orders/index'
    end
  end

  def find_user
    @user = User.find_by_id(current_user.id)
  end

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