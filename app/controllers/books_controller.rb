class BooksController < ApplicationController
  include CurrentCart
  include BooksHelper

  before_action :set_cart, only: %i(show update)

  def show
    set_product
    @user = User.find_by_id(current_user.id) if current_user
    set_views(@product)
  end

  def update
    if params[:quantity].to_i <= 0
      redirect_to book_path
      return
    end
    set_product
    @line_item = @cart.add_product(@product.id, params[:quantity])
    @line_item.save
    redirect_to @line_item.cart
  end

  private

  def set_product
    @product = Product.find_by_id(params[:id])
  end
end 
 