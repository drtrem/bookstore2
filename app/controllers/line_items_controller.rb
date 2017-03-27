class LineItemsController < InheritedResources::Base
  include CurrentCart

  before_action :set_cart, only: [:index, :create, :update, :destroy]

  def index
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product.id)
    @line_item.save
    redirect_to product_path
  end

  def new
    @line_item = LineItem.new
  end

  def create
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product.id)

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
    product = Product.find(params[:product_id])
    @line_item = @cart.del_product(product.id)

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
    product = Product.find(params[:product_id])
    @line_item = @cart.destroy_product(product.id)

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
end
