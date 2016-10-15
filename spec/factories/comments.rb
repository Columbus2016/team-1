FactoryGirl.define do
  factory :comment do
    shout
    user
    body { Faker::Lorem.paragraph }
  end
end
