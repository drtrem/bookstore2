FactoryGirl.define do
  factory :order do
    sequence(:id)   { |i| i+20 }
    order_number "1"
    card_number "1111222233334444"
    name_on_card "MyString"
    mm_yy "11/17"
    cvv "222"
    delivery_id 1
  end
end
