Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  root to: "posts#index"

  resources :users, only: %i[index show]
  resources :posts, only: %i[index create] do
    resources :comments, only: [:create]
    resources :likes, only: %i[create destroy]
  end
  resources :friendships, only: %i[create destroy update]

  delete "friendships/destroypair/:id", to: "friendships#destroypair"
  patch "friendships/acceptpair/:id", to: "friendships#acceptpair"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
