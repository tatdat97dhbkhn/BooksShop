FactoryBot.define do
  factory :book do
    name {Faker::Name.name}
    description {Faker::Lorem.characters(10)}
    price {(Faker::Number.between(3, 15))}
    public_date {Faker::Date.backward(14)}
    image {Faker::Avatar.image}
    author { Author.first || association(:author) }
    category { Category.first || association(:category) }
  end

  factory :invalid_book, parent: :book do
    name {nil}
  end
end
