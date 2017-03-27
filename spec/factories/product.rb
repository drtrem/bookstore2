FactoryGirl.define do
  factory :product do
    sequence(:id)   { |i| i+20 }
    title           "title"
    price           10
    description     "description"
    year            "24.02.2015"
    dimensions      "dimensions"
    materials       "materials"
    image_url       "image_url"
    association(:author)
    association(:category)
    views           1
  end
end
