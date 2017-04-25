class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy

  def add_product(product_id, quantity = nil)
    current_item = line_items.find_by(product_id: product_id)
    if current_item
      current_item.quantity += if quantity
                                 quantity.to_i
                               else
                                 1
                               end
    else
      current_item = line_items.build(product_id: product_id)
    end
    current_item
  end

  def del_product(product_id)
    current_item = line_items.find_by(product_id: product_id)
    unless current_item.nil?
      if current_item.quantity > 1
        current_item.quantity -= 1
      else
        current_item.destroy
      end
    end
    current_item
  end

  def destroy_product(product_id)
    current_item = line_items.find_by(product_id: product_id)
    current_item.destroy
  end

  def total_price
    line_items.to_a.sum(&:total_price)
  end

  def total_cupon
    @cupon = Cupon.find(cupon_id)
    @cupon.price
  end
end
