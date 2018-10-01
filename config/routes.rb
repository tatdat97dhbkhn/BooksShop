Rails.application.routes.draw do
  devise_for :users
  root "books#index"
  resources :books
  resources :authors
  resources :categories
end
