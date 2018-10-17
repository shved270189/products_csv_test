FactoryBot.define do
  factory :product do
    name { Faker::Name.name }
    sku  { Faker::Code.unique.isbn }
    barcode { Faker::Code.nric }
    price { Faker::Number.between(100, 10000) }
  end
end
