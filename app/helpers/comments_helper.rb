module CommentsHelper
  def comments_has_error?(field)
    @product.errors.include?(field)
  end

  def comments_error_message(field)
    @product.errors.messages[field][0]
  end

  def commenter_name
  	"#{@user.first_name} #{@user.last_name}"
  end
end
