Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  root 'home#index'

  get 'dashboard' => 'dashboard#index'

  resources :tweets, only: %i[create show] do
    resources :likes, only: %i[create destroy]
    resources :bookmarks, only: %i[create destroy]
    resources :retweets, only: %i[create destroy]
    resources :replies, only: %i[create]
  end

  resources :usernames, only: %i[edit update]
end
