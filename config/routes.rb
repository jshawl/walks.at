Rails.application.routes.draw do
  root to: 'application#root'
  namespace :api do
    resources :events, only: [:index]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
