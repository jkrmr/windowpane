# frozen_string_literal: true

require "rails_helper"

RSpec.describe FeedItem, type: :decorator do
  describe "#date_posted" do
    it "returns a string representation of #created_at" do
      feb3 = Time.zone.parse("3rd Feb 2001 04:05:06 PM")
      feed_item = FeedItem.new(created_at: feb3)

      date_str = feed_item.date_posted

      expect(date_str).to eq "Feb 3 2001 at 4:05pm"
    end
  end

  describe "#tweet_type" do
    it "given a retweet, returns 'retweeted'"
    it "given a non-retweet, returns 'tweeted'"
  end

  describe "#retweet?" do
    it "returns true if a retweet"
    it "returns false if an original tweet"
  end

  describe "#original_tweet" do
    it "returns the underlying original tweet if a retweet"
    it "returns self if not a retweet"
  end

  describe "#entities" do
    it "returns the entities hash from the original tweet"
  end

  describe "#text" do
    it "returns the tweet text from the original tweet"
  end

  describe "#body" do
    it "replaces entities in the tweet text with links or images"
  end

end
