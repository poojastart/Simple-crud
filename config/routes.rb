Rails.application.routes.draw do
  get '/page/:page', action: :index, controller: 'products'
  get "checkouts/create"
  root 'products#index'
  resources :categories
  resources :products
  devise_for :users
  resources :users, only: [:show]
end
