# frozen_string_literal: true

FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "user-#{n}" }
    sequence(:email) { |n| "email-#{n}@email.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end
