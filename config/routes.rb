Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "callbacks" }
  root to: "posts#index"

  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end
  resources :friendships, only: [:create, :destroy, :update]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
