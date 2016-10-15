FactoryGirl.define do
  factory :user do
    handle { Faker::Internet.user_name(nil, %w(_)) }
    sequence(:email) {|n| "#{handle}_#{n}@example.com" }
    password { Faker::Internet.password(8) }
    gender { %w(male female other).sample }
  end
end
