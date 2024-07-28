FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "foo#{n}@gmail.com" }
    password { 'password' }
  end
end
