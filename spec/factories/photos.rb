FactoryBot.define do
  factory :photo do
    name { Faker::Name.name }
    album
  end
end
