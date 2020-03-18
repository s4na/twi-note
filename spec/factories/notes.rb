# frozen_string_literal: true

FactoryBot.define do
  factory :note do
    user
    title { generate(:title) }
    edit_mode { "preview" }
    body { '> @s4na_penguin ありがとうございますー！\n> [Tsuyoshi Hoshino](https://twitter.com/hoppiestar/status/1237048102919389185?ref_src=twsrc%5Etfw)\n' }
    tweets { '[{"id_str":"1237048102919389185","text":"@s4na_penguin ありがとうございますー！","url":"https://twitter.com/hoppiestar/status/1237048102919389185?ref_src=twsrc%5Etfw","markdown":"> @s4na_penguin ありがとうございますー！ \n> [Tsuyoshi Hoshino](https://twitter.com/hoppiestar/status/1237048102919389185?ref_src=twsrc%5Etfw)","user":{"id_str":"182727080","screen_name":"hoppiestar","name":"Tsuyoshi Hoshino"}}]' }
    all_search_result_tweets { '[{"id_str":"1237048102919389185","text":"@s4na_penguin ありがとうございますー！","url":"https://twitter.com/hoppiestar/status/1237048102919389185?ref_src=twsrc%5Etfw","markdown":"> @s4na_penguin ありがとうございますー！ \n> [Tsuyoshi Hoshino](https://twitter.com/hoppiestar/status/1237048102919389185?ref_src=twsrc%5Etfw)","user":{"id_str":"182727080","screen_name":"hoppiestar","name":"Tsuyoshi Hoshino"}}]' }
  end

  sequence :title do |i| "Sendagayarb##{i}" end
end
