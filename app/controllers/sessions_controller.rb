# frozen_string_literal: true

class SessionsController < ApplicationController

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      log_in(user)
      redirect_to root_url, notice: "Welcome, #{user.name}"
    else
      flash.now[:alert] =
        "Sorry, those credentials aren't quite right. Care to try again?"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to login_url, notice: "Come back soon!"
  end

end
