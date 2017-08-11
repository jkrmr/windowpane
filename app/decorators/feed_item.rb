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

  def body
    mentions = entities.fetch("user_mentions", [])
    return text if mentions.empty?

    replacements = mentions.each_with_object({}) do |mention, memo|
      # ensure safe to mark safe
      handle = h.sanitize(mention["screen_name"])

      memo["@#{handle}"] =
        h.link_to("@#{handle}", urls.feed_path(username: handle))
    end

    mentions_to_replace = Regexp.union(replacements.keys)

    text.gsub(mentions_to_replace, replacements)
        .html_safe # rubocop:disable Rails/OutputSafety
        .freeze # freeze so html_safe string can't be modified elsewhere
  end

  private

  def urls
    Rails.application.routes.url_helpers
  end

  def h
    ActionController::Base.helpers
  end

end
