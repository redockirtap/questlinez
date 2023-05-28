# frozen_string_literal: true

FactoryBot.define do
  factory :answer do
    association :user
    body { 'MyText' }

    trait :invalid do
      body { nil }
    end
  end
end
