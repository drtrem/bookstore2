class CartsController < InheritedResources::Base
  
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

  def show
    @cupon ||= Cupon.new(price: 0, id: 1)
    @cart.cupon_id = 1
    @cart.save
  end

  def edit
    @cupon = Cupon.find(params[:id])
    render action: 'show'
  end

  def cupon_apply
    @number = params[:cupon]
    @cupon = Cupon.where(number: @number[:number]).first
    @cupon ||= Cupon.new(price: 0, id: 1)
    @cart.cupon_id = @cupon.id
    @cart.save
    render action: 'show'
  end

  private

  def invalid_cart
    logger.error "Attempt to access invalid cart #{params[:id]}"
    redirect_to store_url, notice: 'Invalid cart'
  end
end

