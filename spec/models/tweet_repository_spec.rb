# frozen_string_literal: true

require "rails_helper"

RSpec.describe TweetRepository, type: :model do
  describe "mock twitter search results" do
    before do
      mock_twitter_search_results!
    end

    let(:tweets) {
      TweetRepository.new("id", "secret")
        .search(
          EXTERNAL_API: 1,
          query: "hoge",
          start_datetime: "2020-02-16 10:00",
          end_datetime: "2020-02-19 11:00"
        )
    }

    it { expect("そろそろリモートワークやらフレックスやら活用していきたいゾ").to eq tweets.first[:text] }
  end

  describe "#search if EXTERNAL_API is nil" do
    let(:tweets) {
      TweetRepository.new("id", "secret")
        .search(
          query: "hoge",
          start_datetime: "2020-02-16 10:00",
          end_datetime: "2020-02-19 11:00",
        )
    }
    it { expect("次回は神速さん！！！ #ginzarails").to eq tweets.first[:text] }
  end
end
