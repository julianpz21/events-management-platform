FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { "password" }
    password_confirmation { "password" }

    trait :admin do
      role { :admin }
    end

    trait :user do
      role { :user }
    end
  end
end
