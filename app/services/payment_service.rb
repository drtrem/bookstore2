class PaymentService

  def initialize(order, cart)
    @order = order
    @cart = cart
  end

  def create_order
    @order.add_line_items_from_cart(@cart)
    @order.cupon_id = @cart.cupon_id
    @order.subtotal = @order.total_price + @order.total_delivery - @order.total_cupon
  end
end