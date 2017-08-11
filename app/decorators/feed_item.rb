# frozen_string_literal: true

# A decorator for a feed item from a twitter user's feed.
# Initialized with a Hash
class FeedItem < OpenStruct

  def self.from_list(list)
    list.map { |item| new(item) }
  end

  def date_posted
    created_at.to_datetime.strftime("%b %-d %Y %l:%M%P")
  end

  def tweet_type
    retweet? ? "retweeted" : "tweeted"
  end

  def retweet?
    retweeted_status.present?
  end

  def original_tweet
    return self unless retweet?
    @original_tweet ||= OpenStruct.new(retweeted_status)
  end

  def entities
    original_tweet["entities"]
  end

  def text
    original_tweet["text"]
  end

  def body
    mentions = entities.fetch("user_mentions", [])
    urls = entities.fetch("urls", [])
    hashtags = entities.fetch("hashtags", [])
    media = entities.fetch("media", [])
    all_entities = mentions.count + urls.count + hashtags.count + media.count
    return text if all_entities.zero?

    replacements = {}

    mentions.each_with_object(replacements) do |mention, memo|
      # ensure safe to mark safe
      handle = h.sanitize(mention["screen_name"])
      handle_label = "@#{handle}"

      memo[handle_label] =
        h.link_to(handle_label, url_helpers.feed_path(username: handle))
    end

    urls.each_with_object(replacements) do |url, memo|
      memo[url["url"]] =
        h.link_to(url["display_url"], url["expanded_url"])
    end

    hashtags.each_with_object(replacements) do |hashtag, memo|
      hashtag_label = '##{hashtag["text"]}'
      memo[hashtag_label] =
        h.link_to(hashtag_label,
                  "https://twitter.com/hashtag/#{hashtag['text']}")
    end

    media.each_with_object(replacements) do |media_item, memo|
      next unless media_item["type"] == "photo"
      url = media_item["url"]
      img_src = media_item["media_url_https"]
      dimensions = media_item["sizes"]["small"]

      memo[url] = h.image_tag(img_src,
                              height: dimensions["h"],
                              width: dimensions["w"],
                              class: "image-thumbnail")
    end

    to_replace = Regexp.union(replacements.keys)

    text.gsub(to_replace, replacements)
        .html_safe # rubocop:disable Rails/OutputSafety
        .freeze # freeze so html_safe string can't be modified elsewhere
  end

  private

  def url_helpers
    Rails.application.routes.url_helpers
  end

  def h
    ActionController::Base.helpers
  end

end
