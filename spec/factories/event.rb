FactoryBot.define do
  factory :event do
    name { Faker::Lorem.word }
    date { Date.tomorrow }
    description { Faker::Lorem.word }
    place { Faker::Lorem.word }
    capacity { Faker::Number.number(digits: 2) }
    category { 1 }
    association :user
  end
end
