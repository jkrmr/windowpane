# frozen_string_literal: true

module Presenter

  private

  def url_helpers
    Rails.application.routes.url_helpers
  end

  def h
    ActionController::Base.helpers
  end

end
