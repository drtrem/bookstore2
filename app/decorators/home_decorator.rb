class HomeDecorator < Draper::Decorator
  delegate_all

  def image
    object.image_url
  end
end
 