# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root to: 'places#index'
  resources :places
  resources :events, only: [:index] do
    get "explore", on: :collection
  end
  resources :bookmarks
  namespace :api do
    resources :events, only: [:index]
    resources :places, only: %i[create index destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
