# frozen_string_literal: true

class Api::TweetsController < ApplicationController
  before_action :set_api_tweet, only: [:show, :edit, :update, :destroy]

  def index
    tweet = TweetRepository.new(ENV["TWITTWE_APP_ID"], ENV["TWITTWE_APP_SECRET"])
    @tweets = tweet.search(params)
  end
end
