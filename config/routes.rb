Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:update]

  #Adds a /topics/(id)/posts/(id), links posts to topics aka nested routes
  resources :topics do
    resources :posts, except: [:index]
  end

  resources :posts do
    resources :comments, only: [:create]
  end

  get 'about' => 'welcome#about'

  root to: 'welcome#index'
end

