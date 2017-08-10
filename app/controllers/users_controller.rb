# frozen_string_literal: true

class UsersController < ApplicationController

  def new
    locals user: User.new
  end

  def create
    user = User.new(user_params)

    if user.save
      log_in(user)
      redirect_to root_url, notice: "Welcome!"
    else
      flash.now[:alert] = user.errors.full_messages
      render :new, status: :not_found
    end
  end

  private

  def user_params
    params
      .require(:user)
      .permit(:name, :email, :password, :password_confirmation)
  end

end
