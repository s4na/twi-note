# frozen_string_literal: true

require "test_helper"
require "webmock/minitest"

class TweetRepositoryTest < ActiveSupport::TestCase
  test "#search" do
    # get oauth token
    stub_request(:post, "https://api.twitter.com/oauth2/token").
      with(
        body: { "grant_type"=>"client_credentials" },
        headers: {
        "Accept"=>"*/*",
        "Authorization"=>"Basic Rm5JdTJsSnhnQWlTU00ySzBVTDVkTURSVzo4MVBZME9ISHZWWTRraUxQTHNVZmNwUUdiTDhXdTNraThMSWtLemt5UmltM21qU0VDMg==",
        "Connection"=>"close",
        "Content-Type"=>"application/x-www-form-urlencoded",
        "Host"=>"api.twitter.com",
        "User-Agent"=>"TwitterRubyGem/6.2.0"
        }).
      to_return(
        status: 200,
        body: { "token_type": "bearer", "access_token": "AAAA%2FAAA%3DAAAAAAAA" }.to_json,
        headers: {
          'Content-Type': "application/json; charset=utf-8",
        }
      )

    # get twitter response
    stub_request(:get, "https://api.twitter.com/1.1/search/tweets.json?count=100&exclude=retweets&q=hoge&result_type=recent&since_id&until=2020-02-19").
    with(
      headers: {
      "Authorization"=>"Bearer AAAA%2FAAA%3DAAAAAAAA",
      "Connection"=>"close",
      "Host"=>"api.twitter.com",
      "User-Agent"=>"TwitterRubyGem/6.2.0"
      }).
    to_return(
      status: 200,
      body:
        {
          statuses: [
            {
              created_at: "Tue Feb 18 23:59:57 +0000 2020",
              id: 1229918506226864128,
              id_str: "1229918506226864128",
              text: "そろそろリモートワークやらフレックスやら活用していきたいゾ",
              user: {
                id_str: "3018621859",
              },
            }
          ]
        }.to_json,
      headers: {
        'Content-Type': "application/json; charset=utf-8",
      }
    )

    tweets = TweetRepository.new(ENV["TWITTWE_APP_ID"], ENV["TWITTWE_APP_SECRET"])
      .search(
        query: "hoge",
        start_datetime: "2020-02-16 10:00",
        end_datetime: "2020-02-19 11:00",
        EXTERNAL_API: 1
      )

    assert_equal "そろそろリモートワークやらフレックスやら活用していきたいゾ", tweets.first[:text]
  end
end
