FactoryGirl.define do
  factory :line_item do
    product_id { FFaker.numerify('#') }
    cart_id    { FFaker.numerify('#') }
    quantity   { FFaker.numerify('#') }
    order_id   { FFaker.numerify('#') }
  end
end
