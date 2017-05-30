FactoryGirl.define do
  factory :user do
    email               { FFaker::Internet.email }
    first_name          { FFaker::Name.first_name }
    last_name           { FFaker::Name.last_name }
    address             { FFaker::Address.street_name }
    city                { FFaker::Address.city }
    zip                 { 11_111 }
    country             { 'Ukraine' }
    phone               { '+380661026745' }
    shipping_first_name { FFaker::Name.first_name }
    shipping_last_name  { FFaker::Name.last_name }
    shipping_address    { FFaker::Address.street_name }
    shipping_city       { FFaker::Address.city }
    shipping_zip        { 11_111 }
    shipping_country    { 'Ukraine' }
    shipping_phone      { '+380661026745' }
    role                { 'admin' }
    pictures            { 'test' }
  end
end
