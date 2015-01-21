Rails.application.routes.draw do
  devise_for :users

  #Adds a /topics/(id)/posts/(id), links posts to topics aka nested routes
  resources :topics do
    resources :posts, except: [:index]
  end

  get 'about' => 'welcome#about'

    root to: 'welcome#index'
end
