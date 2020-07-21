Rails.application.routes.draw do
  root 'posts#index'

  devise_for :users

  resources :users, only: %i[index show]
  resources :posts, only: %i[index create] do
    resources :comments, only: [:create]
    resources :likes, only: %i[create destroy]
  end
  resources :friendships, only: %i[create destroy update]

  delete 'friendships/destroypair/:id', to: 'friendships#destroypair'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
