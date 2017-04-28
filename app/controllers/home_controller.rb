require_dependency "app/queries/home_products.rb"
class HomeController < ApplicationController
  def index
    @slide = HomeDecorator.decorate_collection(Product.where(category_id: 2).take(2))
    @product = HomeDecorator.decorate_collection(HomeProducts.new.call_best_sellers)
  end

  def create
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product.id)
    @line_item.save
    redirect_to home_index_path
  end
end
 