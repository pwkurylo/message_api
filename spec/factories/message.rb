FactoryBot.define do
  factory :message do
    message { 'test message' }
    password { true }
    read_at { nil }
    uniq_key { SecureRandom.uuid }

    trait :already_read do
      read_at { Time.now }
    end

  end
end