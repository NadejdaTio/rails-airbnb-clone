Rails.application.routes.draw do
  get 'player_reviews/index'

  get 'player_reviews/show'

  get 'player_reviews/new'

  get 'player_reviews/create'

  get 'player_reviews/update'

  get 'player_reviews/edit'

  get 'player_reviews/destroy'

  get 'pages/home'

  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
