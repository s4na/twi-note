# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { "testuser" }
    email { "test@hoge.hoge" }
    provider { "twitter" }
    uid { 1 }
    password { "hogehoge" }
  end
end
