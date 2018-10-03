Rails.application.routes.draw do
  devise_for :users

  root "books#home"
  get "/select_search", to: "books#select_search",
    as: "select_search"
  get "/search_book", to: "books#search_book",
    as: "search_book"
  get "/admin_search", to: "books#admin_search",
    as: "admin_search"

  resources :books
  resources :authors
  resources :categories
end
