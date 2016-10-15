FactoryGirl.define do
  factory :shout do
    user
    body { Faker::Lorem.paragraph }
  end
end
