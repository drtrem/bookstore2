module OrdersHelper
  PARAMS = %w(first_name last_name address city zip country phone).freeze

  def adress_has_error?(field)
    @user.errors.include?(field)
  end

  def adress_error_message(field)
    @user.errors.messages[field][0]
  end

  def copy_params
    PARAMS.each do |param|
      eval("@user.shipping_#{param} = @user.#{param}")
    end
  end
end
 