class ProductPresenter < BasePresenter
  presents :product

  def title 
    product.title
  end

  def price 
    "€#{product.price}0"
  end

  def materials 
    product.materials
  end
  
  def description 
    product.description
  end

  def date
    product.year.strftime("%Y")
  end
  
  def dimensions
    product.dimensions
  end

  def author_name 
    "#{product.author.first_name} #{product.author.last_name}"
  end 

  def image 
    product.image_url
  end

  def avatar(user_id)
    User.find_by_id(user_id).pictures
  end

  def review_rate(review)
    review.rate ||= 0
  end

  def review_date(review)
    review.updated_at.strftime("%B %d, %Y")
  end
end   