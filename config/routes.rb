Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:update, :show, :index]

  #Adds a /topics/(id)/posts/(id), links posts to topics aka nested routes
  resources :topics do
    resources :posts, except: [:index], controller: 'topics/posts'
  end
  
  resources :posts, only: [:index] do 
    resources :comments, only: [:create, :destroy] 
    resources :favorites, only: [:create, :destroy]

    post '/up-vote' => 'votes#up_vote', as: :up_vote
    post '/down-vote' => 'votes#down_vote', as: :down_vote
  end

  get 'about' => 'welcome#about'

  root to: 'welcome#index'
end

