Rails.application.routes.draw do
  devise_for :users
  root "books#home"
  resources :books
  resources :authors
  resources :categories
end
