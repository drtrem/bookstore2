class ViewOrdersDecorator < Draper::Decorator
  delegate_all

  def number
    "R#{object.id}"
  end

  def date
    object.updated_at.strftime("%Y-%m-%d")
  end
end
