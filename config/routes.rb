Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"

  resources :games, only: [:index, :new, :create]
end
