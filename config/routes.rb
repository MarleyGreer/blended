Rails.application.routes.draw do
  devise_for :users, :path_prefix => 'd'
  resources :users, :only => [:show]
  root to: 'pages#home'

  resources :artists do
    resources :chats, only: [:show]
    resources :services, only: [:new, :create, :index]
    resources :bookings, only: [:new, :create]
  end

  resources :services, only: [:destroy, :edit, :update]
  resources :bookings, only: [:index, :show, :edit, :update, :destroy] do
    collection do
      get :pending
      get :confirmed
      get :declined
      get :cancelled
    end
    member do
      patch :confirm
      patch :decline
      patch :cancel
    end
  end

  resources :chats, only: [:index]

end
