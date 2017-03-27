module CommentsHelper
  def comments_has_error?(field)
    @user.errors.include?(field)
  end

  def comments_error_message(field)
    @user.errors.messages[field][0]
  end
end
