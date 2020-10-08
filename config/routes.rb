Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :artists do
    resources :services, only: [:new, :create, :index]
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
      patch :confirm
      patch :decline
      patch :cancel
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
