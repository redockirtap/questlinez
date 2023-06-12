# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    association :user
    title { 'MyTitle' }
    body { 'MyText' }

    trait :invalid do
      title { nil }
    end
  end
end
