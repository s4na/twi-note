# frozen_string_literal: true

FactoryBot.define do
  factory :search_setting do
    note
    query { "ruby" }
    start_datetime { "2019/10/2 10:30" }
    end_datetime { "2019/10/3 12:30" }
  end
end
