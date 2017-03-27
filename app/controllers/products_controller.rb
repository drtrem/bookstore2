class ProductsController < ApplicationController
  
  def show
    view_param_sort
    @catego = Array.new
    Category.all.each {|c| @catego << c.id}
    session[:category] ||= @catego
    @product = Product.order(sort_column + ' ' + sort_direction).where(category_id: session[:category]).page(params[:page]).per(8)
    @categories = Category.all
  end

  def category
    view_param_sort
    if params[:id] == 'all'
      @product = Product.order(sort_column + ' ' + sort_direction).where(category_id: session[:category]).page(params[:page]).per(8)
      @catego = Array.new
      Category.all.each {|c| @catego << c.id}
      session[:category] = @catego
    else
      session[:category] = params[:id]
      @product = Product.where(category_id: params[:id]).page(params[:page]).per(8)
    end
    @categories = Category.all
    render 'show' 
  end

  private

  def sort_column
    Product.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "desc"
  end

  def view_param_sort
    if params[:name_sort].nil?
      @name_sort = 'Newest first'
    else
      @name_sort = params[:name_sort]
    end
  end
end