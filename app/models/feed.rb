# frozen_string_literal: true

class Feed < ApplicationRecord

  validates :username, presence: true

  def self.recent_entries_for(username:, minutes_ago: 5)
    where(username: username)
      .where("created_at >= ?", minutes_ago.minutes.ago)
      .limit(1)
      .order(created_at: :desc)
      .first
  end

  def self.for_user(username)
    if (recent_entry = recent_entries_for username: username)
      return recent_entry
    end

    # invalidate any old entries
    where(username: username).delete_all

    # query the Twitter API for recent_tweets
    tweets = TwitterAPI.instance.fetch_tweets(username: username)
    tweet_attrs = tweets.map(&:to_h)

    create(username: username, payload: tweet_attrs)
  end

end
