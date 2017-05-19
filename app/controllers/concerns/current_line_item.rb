module CurrentLineItem
  extend ActiveSupport::Concern

  private

  def set_line_item(id)
  	product = Product.find(id)
    @line_item = @cart.add_product(product.id)
    @line_item.save
  end
end
