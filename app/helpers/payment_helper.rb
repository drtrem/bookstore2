module PaymentHelper
  def card_has_error?(field)
    @order.errors.include?(field)
  end

  def card_error_message(field)
    @order.errors.messages[field][0]
  end
end
