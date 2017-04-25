class BooksController < ApplicationController
  include CurrentCart

  before_action :set_cart, only: %i(show update)
  helper_method :quantity

  def show
    @product = Product.find_by_id(params[:id])
    @user = User.find_by_id(current_user.id) if current_user
    @product.views += 1
    @product.save
    @reviews = Comment.where(product_id: @product.id, state: 'true')
  end

  def update
    if params[:quantity].to_i <= 0
      redirect_to book_path
      return
    end
    product = Product.find_by_id(params[:id])
    @line_item = @cart.add_product(product.id, params[:quantity])
    @line_item.save
    redirect_to @line_item.cart
  end
end
