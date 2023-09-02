Rails.application.routes.draw do
  get 'meetups/show'
  get 'meetups/new'
  get 'meetups/index'
  get 'meetups/create'
  get 'meetups/update'
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
