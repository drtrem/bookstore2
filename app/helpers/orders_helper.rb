module OrdersHelper
  def adress_has_error?(field)
    @user.errors.include?(field)
  end

  def adress_error_message(field)
    @user.errors.messages[field][0]
  end

  def copy_params
    @user.shipping_first_name = @user.first_name
    @user.shipping_last_name = @user.last_name
    @user.shipping_address = @user.address
    @user.shipping_city = @user.city
    @user.shipping_zip = @user.zip
    @user.shipping_country = @user.country
    @user.shipping_phone = @user.phone
  end
end
 