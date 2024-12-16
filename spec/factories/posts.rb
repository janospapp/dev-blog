FactoryBot.define do
  factory :post do
    title { Faker::Book.title }
    summary { Faker::Lorem.sentences(number: 4).join }
    body { Faker::Lorem.paragraphs(number: 3).join }
    published_at { nil }
    visitor_count { 1 }

    trait :published do
      published_at { rand(1..7).days.ago }
    end
  end
end
