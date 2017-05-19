class CartsController < InheritedResources::Base
  include CartsHelper
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart
  before_filter :authenticate_user!
  load_and_authorize_resource

  def show
    set_cupon
  end

  def edit
    @cupon = Cupon.find(params[:id])
    render 'show'
  end

  def cupon_apply
    set_cupon(params[:cupon][:number])
    render 'show'
  end

  private

  def invalid_cart
    logger.error "Attempt to access invalid cart #{params[:id]}"
    redirect_to store_url, notice: 'Invalid cart'
  end
end
  