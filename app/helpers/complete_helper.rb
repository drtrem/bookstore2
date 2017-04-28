module CompleteHelper
  def clear_cart
    Cart.destroy(session[:cart_id])
    session[:cart_id] = nil
    session[:order_id] = nil
    session[:return_to] = nil
  end
end
