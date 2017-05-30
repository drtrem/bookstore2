require_dependency "app/queries/home_products.rb"
class HomeController < ApplicationController
  include CurrentLineItem

  def index
    @slide = HomeDecorator.decorate_collection(Product.slide)
    @product = HomeDecorator.decorate_collection(HomeProducts.new.call_best_sellers)
  end

  def create
    set_line_item(params[:product_id])
    redirect_to home_index_path
  end
end
 