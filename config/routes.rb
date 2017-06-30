Rails.application.routes.draw do
  root 'posts#index'
  devise_for :users
  resources :users, only: :show
  resources :posts, only: [:index, :new, :show, :create]

end
