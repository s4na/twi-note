# frozen_string_literal: true

require "test_helper"

class TweetRepositoryTest < ActiveSupport::TestCase
  test "#search" do
    mock_twitter_search_results!

    tweets = TweetRepository.new("id", "secret")
      .search(
        EXTERNAL_API: 1,
        query: "hoge",
        start_datetime: "2020-02-16 10:00",
        end_datetime: "2020-02-19 11:00"
      )

    assert_equal "そろそろリモートワークやらフレックスやら活用していきたいゾ", tweets.first[:text]
  end

  test "#search if EXTERNAL_API is nil" do
    tweets = TweetRepository.new("id", "secret")
      .search(
        query: "hoge",
        start_datetime: "2020-02-16 10:00",
        end_datetime: "2020-02-19 11:00",
      )

    assert_equal "次回は神速さん！！！ #ginzarails", tweets.first[:text]
  end
end
