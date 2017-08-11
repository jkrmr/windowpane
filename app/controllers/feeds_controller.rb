# frozen_string_literal: true

class FeedsController < ApplicationController

  before_action :authenticate!

  def show
    username = params.require(:username)

    feed = Feed.for_user(username)
    tweets = FeedItem.from_list(feed.payload)

    locals tweets: tweets
  rescue ActionController::ParameterMissing
    redirect_to root_url, alert: "Please provide a Twitter handle."
  end

end
