Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :topics, only: :show do
    resources :favorite_topics, only: :create
  end

  resources :favorite_topics, only: [:index, :destroy]

  resources :bookmarked_articles, only: [:index, :show, :create]
end
