# frozen_string_literal: true

class UsersController < ApplicationController

  def new
    locals user: User.new
  end

  def create
    user = User.new(user_params)

    if user.save
      log_in(user)
      redirect_to root_url, notice: "Welcome, #{user.name}!"
    else
      render :new,
             locals: { user: user },
             status: :unprocessable_entity
    end
  end

  private

  def user_params
    params
      .require(:user)
      .permit(:name, :email, :password, :password_confirmation)
  end

end
