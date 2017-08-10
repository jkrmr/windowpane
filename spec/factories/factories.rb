# frozen_string_literal: true

FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "user-#{n}" }
    sequence(:email) { |n| "email-#{n}@email.com" }
  end
end
