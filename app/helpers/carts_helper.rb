module CartsHelper
  def set_cupon(number_cupon = 0)
    @cupon = Cupon.find_by_number(number_cupon)
    @cupon ||= Cupon.new(price: 0, id: 1)
    @cart.cupon_id = @cupon.id
    @cart.save
  end
end
