Rails.application.routes.draw do
  get 'user_meetups/create'
  get 'user_meetups/update'
  get 'meetups/show'
  get 'meetups/new'
  get 'meetups/index'
  get 'meetups/create'
  get 'meetups/update'
  get "meetups/:id/booking_confirmation", to: "bookings#booking_confirmation", as: :booking_confirmation_meetup
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :meetups do
    resources :user_meetups
    resource :chatroom, only: [:show, :create, :destroy] do
      resources :messages, only: :create
    end

    member do
      post 'create_chatroom'
      get 'confirmation' # Custom route for the confirmation page
    end
  end
  post "/join_meetup", to: "meetups#join", as: :join_meetup

end
