FactoryGirl.define do
  factory :product do
    id              { FFaker.numerify('#') }
    title           { FFaker::Book.title }
    price           { FFaker.numerify('##.##') }
    description     { FFaker::DizzleIpsum.paragraphs }
    year            { '24.02.2015' }
    dimensions      { "#{FFaker.numerify('#.#')}\" #{FFaker.numerify('#.#')}\" #{FFaker.numerify('#.#')}\"" }
    materials       { FFaker::Lorem.words.join ', ' }
    image_url       'image_url'
    association(:author)
    association(:category)
    views           { FFaker.numerify('#') }
  end
end
