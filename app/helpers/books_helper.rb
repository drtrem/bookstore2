module BooksHelper
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
