Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :topics, only: :show do
    collection do
      get :search
    end
    resources :favorite_topics, only: :create
  end

  resources :favorite_topics, only: [:index, :destroy] do
    collection do
      get :tweets
    end
  end

  resources :bookmarked_articles, only: [:index, :show, :create, :destroy]
end
