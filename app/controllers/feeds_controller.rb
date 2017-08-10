# frozen_string_literal: true

class FeedsController < ApplicationController

  def show
    username = params[:username]

    feed = Feed.for_user(username)
    tweets = FeedItem.from_list(feed.payload)

    locals tweets: tweets
  end

end
