Rails.application.routes.draw do
  devise_for :users, :path_prefix => 'd'
  resources :users, :only => [:show]
  root to: 'pages#home'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
