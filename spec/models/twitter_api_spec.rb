# frozen_string_literal: true

require "rails_helper"

RSpec.describe TwitterAPI, type: :model do
  describe "#fetch_tweets" do
    it "returns an iterable collection of tweets" do
      VCR.use_cassette("twitter-api-everythinggoats-25") do
        tweets = TwitterAPI
                 .instance
                 .fetch_tweets(username: "everythinggoats")

        expect(tweets).to respond_to(:each)
        expect(tweets.count).to eq(25)
      end
    end

    it "accepts a target size for the queried collection" do
      VCR.use_cassette("twitter-api-everythinggoats-5") do
        tweets = TwitterAPI
                 .instance
                 .fetch_tweets(username: "everythinggoats", count: 5)

        expect(tweets.count).to eq(5)
        expect(tweets.first.user.screen_name).to eq "EverythingGoats"
      end
    end

    context "given a count of zero" do
      it "returns the API default of 20 tweets" do
        VCR.use_cassette("twitter-api-everythinggoats-0") do
          tweets = TwitterAPI
                   .instance
                   .fetch_tweets(username: "everythinggoats", count: 0)
          expect(tweets.count).to eq 20
        end
      end
    end

    context "given a twitter username associated with a private feed" do
      it "returns an empty array" do
        VCR.use_cassette("twitter-api-divya-25") do
          tweets = TwitterAPI.instance.fetch_tweets(username: "divya")
          expect(tweets).to eq []
        end
      end
    end
  end
end
