Rails.application.routes.draw do
  devise_for :users, :path_prefix => 'd'
  resources :users, :only => [:show]
  root to: 'pages#home'

  resources :chats, only: [:create, :show]

  resources :artists do
    resources :services, only: [:new, :create]
    resources :bookings, only: [:create, :show]
  end

  resources :services, only: [:destroy, :edit, :update]
  resources :bookings, only: [:index, :edit, :update, :destroy] do
  resources :services_bookings, only: [:create]
    collection do
      get :pending
      get :confirmed
      get :declined
      get :cancelled
    end
    member do
      get :details
      patch :confirm
      patch :decline
      patch :cancel
    end
  end

  resources :chats, only: [:index]

end
