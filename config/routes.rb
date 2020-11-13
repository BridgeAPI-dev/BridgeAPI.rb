# frozen_string_literal: true

Rails.application.routes.draw do
  resource :user, except: :index
  resources :bridges

  post 'login', to: 'sessions#create'
  get 'events', to: 'events#index'
end
