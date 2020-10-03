Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :artists do
    resources :services, only: [:new, :create, :index]
  end

  resources :services, only: [:destroy, :edit, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
