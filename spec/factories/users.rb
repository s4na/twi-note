# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { generate(:name) }
    uid { generate(:uuid) }
    email { generate(:email) }
    provider { "twitter" }
    password { "hogehoge" }
  end

  sequence :name do |i| "User_#{i}" end
  sequence :uuid do |i| "#{i}" end
  sequence :email do |i| "#{i}-twitter@example.com" end
end
