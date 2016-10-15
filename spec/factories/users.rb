FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "#{name}_#{n}@example.com" }
    handle { Faker::Internet.user_name(nil, %w(_)) }
    password { Faker::Internet.password(8) }
  end
end
