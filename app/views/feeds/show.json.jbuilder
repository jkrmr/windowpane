# frozen_string_literal: true

json.user user
json.tweets tweets, :tweet_type, :date_posted, :body
