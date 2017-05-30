FactoryGirl.define do
  factory :cart do
    id       { FFaker.numerify('#') }
    cupon_id { FFaker.numerify('#') }
    factory :liner_item do
      product
    end
  end
end
