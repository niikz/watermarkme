# frozen_string_literal: true

Rails.application.routes.draw do
  root 'welcome#index'

  get '/', to: 'welcome#index', as: 'welcome'
  get 'privacy', to: 'welcome#privacy', as: 'privacy'
  get 'terms', to: 'welcome#terms', as: 'terms'

  resources :tweets, only: %i(new create)
  post '/tweets/new', to: 'tweets#create', as: 'create_tweet'

  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
