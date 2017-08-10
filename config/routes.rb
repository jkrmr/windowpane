# frozen_string_literal: true

Rails.application.routes.draw do

  resource :dashboard, only: :index
  resource :feed, only: :show
  resources :users, only: %i[new create]

  get "/signup", to: "users#new", as: :signup

  get "/login", to: "sessions#new", as: :login
  post "/login", to: "sessions#create", as: :sessions
  delete "/logout", to: "sessions#destroy", as: :logout

  root to: "dashboard#index"

end
