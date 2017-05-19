FactoryGirl.define do
  factory :comment do
  	commenter { FFaker::Name.name }
    title  { FFaker::Lorem.phrase }
    body   { FFaker::Lorem.sentences }
    rate { rand(0..5) }

    trait :approved do
      state 'approved'
    end

    trait :rejected do
      state 'rejected'
    end
  end
end
