Rails.application.routes.draw do
  root 'posts#index'
  get '/posts/show_matching_keyword' , to: 'posts#show_matching_keyword'
  devise_for :users
  resources :users, only: :show
  resources :posts, only: [:index, :new, :show, :create] do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: :create
  end
  resources :keywords, only: [:index, :create, :edit, :update, :destroy]
end
