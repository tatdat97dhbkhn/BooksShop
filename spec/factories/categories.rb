FactoryBot.define do
  factory :category do
    name {Faker::Name.name}
    description {"Pham Tat Dat"}
  end

  factory :invalid_category, parent: :category do
    name {nil}
  end
end
