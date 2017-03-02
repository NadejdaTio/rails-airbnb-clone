Rails.application.routes.draw do

  get 'player_reviews/index'

  get 'player_reviews/new'

  get 'player_reviews/show'

  get 'player_reviews/create'

  get 'player_reviews/edit'

  get 'player_reviews/update'

  get 'player_reviews/destroy'

  get 'owner_reviews/index'

  get 'owner_reviews/new'

  get 'owner_reviews/show'

  get 'owner_reviews/create'

  get 'owner_reviews/edit'

  get 'owner_reviews/update'

  get 'owner_reviews/destroy'

  mount Attachinary::Engine => "/attachinary"

  get 'pages/home'
  resources :games, only: [:edit, :show, :index, :destroy, :update]
  resources :profiles, only: [:edit, :show, :index, :destroy, :new, :create, :update] do
    resources :games, only: [:new, :create]
  end
  resources :orders, only: [:edit, :show, :index, :destroy, :new, :create, :update]

  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
