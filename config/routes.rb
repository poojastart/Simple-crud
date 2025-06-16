Rails.application.routes.draw do
  get '/page/:page', action: :index, controller: 'products'
  get "checkouts/create"
  root 'products#index'
  resources :products
  devise_for :users
end
