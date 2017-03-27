class OrdersController < InheritedResources::Base
  include CurrentCart

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
      session[:return_to] = nil
      @order = Order.find(session[:order_id])
      @delivery = Delivery.find(@order.delivery_id)
      session[:return_to] = true
      if @user.update_attributes(user_params)
        render 'confirm/index'
      else
        render 'orders/index'
      end
    end
    copy_params
    @user.save
  end

  private

  def user_params
      params.require(:user).permit(:first_name, :last_name, :address, :city, :zip, :country, :phone)
  end

  def copy_params
    @user.shipping_first_name = @user.first_name
    @user.shipping_last_name = @user.last_name
    @user.shipping_address = @user.address
    @user.shipping_city = @user.city
    @user.shipping_zip = @user.zip
    @user.shipping_country = @user.country
    @user.shipping_phone = @user.phone
  end
end
