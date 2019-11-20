# frozen_string_literal: true

class Api::TweetsController < ApplicationController
  before_action :set_api_tweet, only: [:show, :edit, :update, :destroy]

  def index
    if Rails.env.test?
      result_tweets = {}
      file_path = "#{Rails.root}/test/fixtures/files/twitter_api_search_response.json"
      open(file_path) do |file|
        result_tweets = JSON.load(file)
      end

      @tweets = []
      result_tweets.each do |tweet|
        result = JSON.parse(tweet.to_json, { symbolize_names: true })
        @tweets.push(result)
      end
    else
      @tweets = Tweet.all(params)
    end
  end
end
