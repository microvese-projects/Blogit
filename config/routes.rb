# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "users#index"
  get '/', to: 'users#index'
  get '/users', to: 'users#index'
  get '/users/:id', to: 'users#profile'
  get '/users/:id/posts', to: 'posts#index'
end
