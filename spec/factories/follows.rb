# frozen_string_literal: true

FactoryBot.define do
  factory :follow do
    user
    followee
  end
end
