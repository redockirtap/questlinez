# frozen_string_literal: true

FactoryBot.define do
  factory :answer do
    association :user
    body { 'MyText' }
    # best { false }

    trait :invalid do
      body { nil }
    end

    # trait :best do
    #   best { true }
    # end
  end
end
