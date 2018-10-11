FactoryBot.define do
  factory :author do
    name {Faker::Name.name}
  end

  factory :invalid_author, parent: :author do
    name {nil}
  end
end
