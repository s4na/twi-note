# frozen_string_literal: true

class TweetRepository
  def initialize(twitter_app_id, twitter_app_secret)
    @twitter_app_id = twitter_app_id
    @twitter_app_secret = twitter_app_secret
  end

  def search(params)
    set_params(params)
    tweets(params)
  end

  private
    def set_params(params)
      @query = params[:query]
      @start_datetime = Time.strptime(params[:start_datetime], "%Y-%m-%d %H:%M").to_time
      @end_datetime = Time.strptime(params[:end_datetime], "%Y-%m-%d %H:%M").to_time
      @end_date = I18n.l(@end_datetime, format: :ymd_hy)
      @since_id = nil
    end

    def tweets(params)
      search_tweets(params)
      add_tweet_params
      sort_tweet_asc
      @tweets
    end

    def search_tweets(params)
      if (Rails.env.test? || ENV["NO_EXTERNAL_API"]) && !params[:EXTERNAL_API]
        load_file_tweets
      else
        search_on_twitter
      end
    end

    def client
      @client ||= Twitter::REST::Client.new(
        consumer_key: @twitter_app_id,
        consumer_secret: @twitter_app_secret
      )
    end

    def load_file_tweets
      file_path = "#{Rails.root}/test/fixtures/files/twitter_api_search_response.json"
      result_tweets = open(file_path) do |file|
        JSON.load(file)
      end

      @tweets = []
      result_tweets.each do |tweet|
        result = JSON.parse(tweet.to_json, { symbolize_names: true })
        @tweets.push(result)
      end
    end

    def search_on_twitter
      result_tweets = client.search(
        @query,
        count: 100,
        result_type: "recent",
        until: @end_date,
        exclude: "retweets",
        since_id: @since_id).to_h
      @tweets = result_tweets[:statuses]

      extract_time_period
    end

    def extract_time_period
      @tweets.select! do |tweet|
        tweet_datetime = Time.parse(tweet[:created_at].to_s)
        (@start_datetime < tweet_datetime) && (@end_datetime > tweet_datetime)
      end
    end

    def add_tweet_params
      @tweets.each do |tweet|
        tweet[:url] = "https://twitter.com/#{tweet[:user][:screen_name]}/status/#{tweet[:id_str]}?ref_src=twsrc%5Etfw"
        tweet[:markdown] = "> #{tweet[:text]} ".gsub(/\R/, " ") + "\n" + "> [#{tweet[:user][:name]}](#{tweet[:url]})".gsub(/\R/, " ")
      end
    end

    def sort_tweet_asc
      @tweets.reverse!
    end
end
