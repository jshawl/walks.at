Rails.application.routes.draw do
  devise_for :users
  root to: 'application#root'
  resources :places
  namespace :api do
    resources :events, only: [:index]
    resources :places, only: [:create,:index,:destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
