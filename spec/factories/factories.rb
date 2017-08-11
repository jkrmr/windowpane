# frozen_string_literal: true

FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "user-#{n}" }
    sequence(:email) { |n| "email-#{n}@email.com" }
    password { "password" }
    password_confirmation { "password" }
  end

  factory :feed do
    sequence(:username) { |n| "username-#{n}" }
    payload { [{ "id" => 982373, "text" => "this is a tweet!" }] }
  end
end
