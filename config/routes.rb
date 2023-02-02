Rails.application.routes.draw do
  devise_for :users
  
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show] do
      resources :comments, only: [:new, :create]
      resources :likes, only: [:new, :create]
    end
  end 
  resources :posts, only: [:new, :create] 
  root 'users#index'
end
