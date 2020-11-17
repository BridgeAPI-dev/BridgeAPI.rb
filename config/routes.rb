# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  resource :user, except: %i[new edit]
  resources :bridges
  resources :headers, :environment_variables, only: :destroy

  post 'login', to: 'sessions#create'
  post 'events', to: 'events#create'
  get 'events', to: 'events#index'
  get 'events/:id', to: 'events#show'
  delete 'events/:id', to: 'events#destroy'
  mount Sidekiq::Web => '/sidekiq'
end
