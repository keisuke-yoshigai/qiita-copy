Rails.application.routes.draw do
  root 'posts#index'
  devise_for :users
  get '/posts/preview' => 'posts#preview'
  resources :users, only: :show
  resources :posts, only: [:index, :new, :show, :create] do
    resources :likes, only: [:create, :destroy]
  end
end
