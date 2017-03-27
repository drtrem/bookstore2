module OrdersHelper
  def adress_has_error?(field)
    @user.errors.include?(field)
  end

  def adress_error_message(field)
    @user.errors.messages[field][0]
  end
end
