Rails.application.routes.draw do
  devise_for :users, :path_prefix => 'd'
  resources :users, :only => [:show]
  root to: 'pages#home'
<<<<<<< HEAD

=======
  resources :artists do
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
>>>>>>> 8375d19031e86b2070de1de958fab3f73746406b
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
