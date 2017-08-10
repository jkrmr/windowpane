# frozen_string_literal: true

# A singleton facade for the twitter client
class TwitterAPI

  include Singleton

  attr_reader :client

  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = Figaro.env.twitter_consumer_key
      config.consumer_secret = Figaro.env.twitter_consumer_secret
      config.access_token = Figaro.env.twitter_access_token
      config.access_token_secret = Figaro.env.twitter_access_secret
    end
  end

  def fetch_tweets(username:, count: 25)
    client.user_timeline(username, count: count)
  rescue Twitter::Error::Unauthorized
    []
  end

end
