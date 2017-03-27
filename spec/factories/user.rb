FactoryGirl.define do
  factory :user do
    email 'dima@test.com'
    first_name 'Dima'
    last_name 'Dima'
    address  'Dniporo'
    city 'Dniporo'
    zip 11111
    country 'Ukraine'
    phone '+380661026745'
    shipping_first_name 'Dima'
    shipping_last_name 'Dima'
    shipping_address 'Dniporo'
    shipping_city 'Dniporo'
    shipping_zip 11111
    shipping_country 'Ukraine'
    shipping_phone '+380661026745'
    role 'admin'
    pictures 'test'
  end
end
