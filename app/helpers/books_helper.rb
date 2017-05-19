module BooksHelper
  def set_views(product)
    product.views += 1
    product.save
    @reviews = Comment.where(product_id: product.id, state: 'true')
  end
end 
 