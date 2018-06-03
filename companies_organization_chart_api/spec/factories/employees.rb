FactoryBot.define do
  factory :employee do
    company
    name Faker::Name.name
    email Faker::Internet.email
  end
end
