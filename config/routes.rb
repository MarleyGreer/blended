Rails.application.routes.draw do
  devise_for :users, :path_prefix => 'd'
  resources :users, :only => [:show]

  get '/messages', to: 'users#messages'

  root to: 'pages#home'

  resources :chats, only: [:create, :show, :index] do
    member do
      patch :favourites
      patch :archive
    end
    collection do
      get :saved
      get :archived
    end

    resources :messages, only: [:create]
  end

  resources :services, only: [:destroy, :edit, :update]
  resources :bookings, only: [:edit, :update, :create, :destroy, :index ] do
  resources :services_bookings, only: [:create]
  resources :reviews, only: [:new, :create, :index]
    collection do
      get :all
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

  resources :artists do
    collection do
      get :top
    end
    resources :services, only: [:new, :create]
    resources :bookings, only: [:new, :show]

  end

  resources :bookings do
    resources :services_bookings, only: [:new]
  end

  resources :bookings do
    member do
      get :selectdate
      get :selecttime
    end
  end


  resources :reviews, only: [:edit, :update]
  resources :bookmarks, only: [:index, :create, :destroy] do
    collection { post :sort }
  end
end
