# frozen_string_literal: true

module WebmockHelper
  def mock_twitter_search_results!
    # twitter oauth token
    stub_request(:post, "https://api.twitter.com/oauth2/token")
      .with(
        body: { "grant_type" => "client_credentials" },
        headers: { "Connection" => "close" }
      )
      .to_return(
        status: 200,
        body: {}.to_json,
        headers: { 'Content-Type': "application/json; charset=utf-8" }
      )
    # return twitter response
    stub_request(:get, "https://api.twitter.com/1.1/search/tweets.json?count=100&exclude=retweets&q=hoge&result_type=recent&since_id&until=2020-02-19")
      .with(headers: { "Connection" => "close" })
      .to_return(
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
        headers: { 'Content-Type': "application/json; charset=utf-8" }
      )
  end
end
