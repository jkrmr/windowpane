# frozen_string_literal: true

class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  def current_user
    return unless session[:user_id]
    @current_user ||= User.find(session[:user_id])
  end
  helper_method :current_user

  def authenticate!
    return if current_user
    redirect_to login_url, notice: "Terribly sorry, would you mind logging in, please?"
  end

  private

  # Render the current action's template with locals in `values.`
  def locals(values)
    if request.xhr?
      render json: { locals: values }
    else
      render locals: values
    end
  end

  def log_in(user)
    flash[:notice] = login_message(user)
    session[:user_id] = user.id
  end

  def log_out
    session[:user_id] = nil
  end

  def login_message(user)
    "Welcome, #{user.name}!"
  end

end
