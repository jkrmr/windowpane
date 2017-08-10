# frozen_string_literal: true

Rails.application.routes.draw do

  resource :dashboard, only: :index
  resource :feed, only: :show
  resources :users, only: :show

  root to: "dashboard#index"

end
