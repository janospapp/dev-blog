FactoryBot.define do
  factory :account do
    email { Faker::Internet.email }
    password_hash { BCrypt::Password.create(password).to_s }
    status { :verified }

    transient do
      password { SecureRandom.hex(7) }
    end
  end
end
