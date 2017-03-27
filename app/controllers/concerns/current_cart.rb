module CurrentCart
  extend ActiveSupport::Concern

  private
  
  def set_cart
    @cart = Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
    @cart = Cart.create
    session[:cart_id] = @cart.id
  end

  def clear_line_items
    @cart.line_items.each do |item|
      item.cart_id = nil
    end
  end
end