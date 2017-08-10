# frozen_string_literal: true

class DashboardController < ApplicationController

  def home
    timeline = TwitterAPI.instance.fetch_tweets
    tweet = timeline.first
    locals tweets: timeline
  end

end
