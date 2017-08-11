# frozen_string_literal: true

require "rails_helper"

RSpec.describe FeedItem, type: :model do
  describe "#date_posted" do
    it "returns a string representation of #created_at" do
      feb3 = Time.zone.parse("3rd Feb 2001 04:05:06 PM")
      feed_item = FeedItem.new(created_at: feb3)

      date_str = feed_item.date_posted

      expect(date_str).to eq "Feb 3 2001  4:05pm"
    end
  end
end
