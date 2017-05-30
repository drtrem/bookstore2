class ProductsController < ApplicationController
  def show
    view_param_sort
    set_category_all
    session[:category] ||= @category
    set_product_by_category
    @categories = Category.all
  end

  def category
    view_param_sort
    if params[:id] == 'all'
      set_category_all
      session[:category] = @category
      set_product_by_category
    else
      session[:category] = params[:id]
      @products = Product.sort_by_category(params).per(8)
    end
    @categories = Category.all
    render 'show'
  end

  private

  def set_category_all
    @category_ids = Category.ids
  end

  def set_product_by_category
    @products = Product.sort_product(params, session).per(8)
  end

  def view_param_sort
    @name_sort = if params[:name_sort].nil?
                   'Newest first'
                 else
                   params[:name_sort]
                 end
  end
end
