FactoryGirl.define do
  factory :cupon do
    id     { FFaker.numerify('#') }
    number { FFaker.numerify('#') }
    price  { FFaker.numerify('##.##') }
  end
end
