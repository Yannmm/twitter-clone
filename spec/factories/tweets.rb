FactoryBot.define do
  factory :tweet do
    user { association(:user) }
    body { Faker::Lorem.paragraph }
  end
end
