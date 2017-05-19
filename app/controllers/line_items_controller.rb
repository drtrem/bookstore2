class LineItemsController < InheritedResources::Base
  include CurrentCart
  include CurrentLineItem

  before_action :set_cart, only: %i(index create update destroy)
  before_action :find_product, only: %i(create update destroy)

  def index
    set_line_item(params[:product_id])
    redirect_to product_path
  end

  def new
    @line_item = LineItem.new
  end

  def create
    @line_item = @cart.add_product(@product.id)
    respond_to do |format|
      if @line_item.save
        format.html { redirect_to @line_item.cart }
      else
        format.html { render action: 'new' }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @line_item = @cart.del_product(@product.id)
    respond_to do |format|
      if @line_item.save
        format.html { redirect_to @line_item.cart }
        format.json { head :no_content }
      else
        format.html { render action: 'new' }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @line_item = @cart.destroy_product(@product.id)
    respond_to do |format|
      if @line_item.save
        format.html { redirect_to @line_item.cart }
        format.json { head :no_content }
      else
        format.html { render action: 'new' }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def find_product
    @product = Product.find(params[:product_id])
  end
end
