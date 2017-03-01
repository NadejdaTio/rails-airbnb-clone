Rails.application.routes.draw do

  mount Attachinary::Engine => "/attachinary"

  get 'pages/home'
  resources :games, only: [:edit, :show, :index, :destroy, :new, :create, :update]
  resources :orders, only: [:edit, :show, :index, :destroy, :new, :create, :update]
  resources :profiles

  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
