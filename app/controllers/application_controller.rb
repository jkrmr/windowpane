# frozen_string_literal: true

class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  # Render the current action's template with locals in `values.`
  def locals(values)
    render locals: values
  end

end
