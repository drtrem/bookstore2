class HomeController < ApplicationController

  def index
    @slide = Product.where(category_id: 2).take(2)
    @product = Product.joins("INNER JOIN products ON products.id = O.product_id")
        .from(LineItem.select("product_id, COUNT(product_id) as count")
        .group("product_id").order("count DESC").limit(4),:O)
  end

  def create
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product.id)
    @line_item.save
    redirect_to home_index_path
  end
end
