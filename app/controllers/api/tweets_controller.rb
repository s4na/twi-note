# frozen_string_literal: true

require "twitter"

class Api::TweetsController < ApplicationController
  before_action :set_api_tweet, only: [:show, :edit, :update, :destroy]

  def index
    query = params[:query]
    start_datetime = Time.strptime(params[:start_datetime], "%Y-%m-%d %H:%M").to_time
    end_datetime = Time.strptime(params[:end_datetime], "%Y-%m-%d %H:%M").to_time
    end_date = I18n.l(end_datetime, format: :ymd)

    client = Twitter::REST::Client.new(
      consumer_key: ENV["CONSUMER_KEY"],
      consumer_secret: ENV["CONSUMER_SECRET"])

    since_id = nil
    result_tweets = client.search(
      query,
      count: 100,
      result_type: "recent",
      until: end_date,
      exclude: "retweets",
      since_id: since_id)

    @tweets = result_tweets.to_h
    @tweets = @tweets[:statuses]
  end
end
