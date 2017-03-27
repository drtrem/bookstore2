FactoryGirl.define do
  factory :cart do
    id 222
    cupon_id 3
    factory :liner_item do
      book
    end
  end
end