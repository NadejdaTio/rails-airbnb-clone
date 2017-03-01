Rails.application.routes.draw do
  get 'pages/home'
  resources :games, only: [:edit, :show, :index, :destroy, :new, :create, :update]
  resources :orders, only: [:edit, :show, :index, :destroy, :new, :create, :update]
  resources :profiles

  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
