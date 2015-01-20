Rails.application.routes.draw do
  get 'welcome/index'

  get 'welcome/about'

  devise_for :users
  resources :posts

  get 'about' => 'welcome#about'

    root to: 'welcome#index'
end
