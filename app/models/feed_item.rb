# frozen_string_literal: true

class FeedItem < OpenStruct

  def self.from_list(list)
    list.map { |item| new(item) }
  end

  def date_posted
    created_at.to_datetime.strftime("%b %-d %Y %l:%M%P")
  end

end
