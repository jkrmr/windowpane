# frozen_string_literal: true

require "rails_helper"

RSpec.describe Feed, type: :model do

  it { should respond_to(:username) }
  it { should respond_to(:payload) }
  it { should validate_presence_of(:username) }

  describe ".recent_entries_for" do
    it "returns only methods for the given user" do
      create(:feed, username: "oppenheimer")
      create(:feed, username: "feynman", created_at: 10.hours.ago)
      entry = create(:feed, username: "feynman")

      feed = Feed.recent_entries_for(username: "feynman")

      expect(feed).to eq entry
    end

    it "returns only entries persisted within n minutes ago" do
      create(:feed, username: "oppenheimer")
      create(:feed, username: "feynman", created_at: 10.minutes.ago)
      entry = create(:feed, username: "feynman", created_at: 4.minutes.ago)

      feed = Feed.recent_entries_for(username: "feynman", minutes_ago: 5)

      expect(feed).to eq entry
    end

    it "returns nil if no recent entries for the given user are found" do
      create(:feed, username: "oppenheimer")
      create(:feed, username: "feynman", created_at: 10.minutes.ago)
      create(:feed, username: "feynman", created_at: 5.minutes.ago)

      feed = Feed.recent_entries_for(username: "feynman", minutes_ago: 5)

      expect(feed).to be_nil
    end
  end

  describe ".for_user" do

    it "given a user with a cached feed, fetches the feed from the cache" do
      create(:feed, username: "oppenheimer")

      feed = Feed.for_user("oppenheimer")

      expect(feed.payload).to be_an_instance_of Array
      expect(feed.payload).to all(be_an_instance_of(Hash))
      expect(feed.username).to eq "oppenheimer"
    end

    it "given a user with a cached empty feed, uses the cached value" do
      create(:feed, username: "oppenheimer", payload: [])

      feed = Feed.for_user("oppenheimer")

      expect(feed.username).to eq "oppenheimer"
      expect(feed.payload).to eq []
    end

    it "given no cache entry for the user, fetches the feed from twitter api" do
      allow(TwitterAPI.instance).to receive(:fetch_tweets)
        .with(username: "everythinggoats")
        .and_return([])

      Feed.for_user("everythinggoats")

      expect(TwitterAPI.instance).to have_received(:fetch_tweets).once
    end

    it "given no recent cache entry for the user, clears stale entries" do
      create(:feed, username: "user", created_at: 7.hours.ago)
      create(:feed, username: "user", created_at: 6.hours.ago)
      create(:feed, username: "user", created_at: 5.hours.ago)
      tweets = [{ "id" => 1, "text" => "tweet!" },
                { "id" => 2, "text" => "tweet!!" }]
      allow(TwitterAPI.instance).to receive(:fetch_tweets)
        .with(username: "user")
        .and_return(tweets)

      fetched_tweets = []
      feed_query = ->(results) { results << Feed.for_user("user") }

      expect { feed_query.call(fetched_tweets) }
        .to change { Feed.count }.from(3).to(1)

      expect(fetched_tweets.first.payload).to eq tweets
    end
  end

end
