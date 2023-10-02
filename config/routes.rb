Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "users#new"
  resources :blogs, only: [:show, :new, :index, :create, :destroy]
  resources :users, only: [:create, :new, :show]
  resources :comments, only: [:create, :destroy]
end