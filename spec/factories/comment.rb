FactoryGirl.define do
  factory :comment do
    commenter      "Dima"
    body           "MyText"
    sequence(:product_id )   { |i| i+20 }
    state          'true'
    user_id        222
    rate           1
  end
end 
