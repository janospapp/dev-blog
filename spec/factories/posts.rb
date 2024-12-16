# == Schema Information
#
# Table name: posts
#
#  id              :bigint           not null, primary key
#  body            :text
#  body_updated_at :datetime
#  published_at    :datetime
#  ref             :string           not null
#  summary         :text
#  title           :string
#  visitor_count   :integer          default(0), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_posts_on_published_at  (published_at)
#  index_posts_on_ref           (ref) UNIQUE
#
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
