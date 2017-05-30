FactoryGirl.define do
  factory :order do
    id               { FFaker.numerify('#') }
    order_number     { FFaker.numerify('##') }
    delivery_id      { FFaker.numerify('#') }
    cvv              { FFaker.numerify('###') }
    mm_yy            { FFaker.numerify('##/##') }
    card_number      { FFaker.numerify('#### #### #### ####') }
    name_on_card     { FFaker::Name.name }
  end
end