Rails.application.routes.draw do
  root 'posts#index'
  resources :users, only: :show
  resources :posts, only: [:new, :show]
  devise_for :users
end
