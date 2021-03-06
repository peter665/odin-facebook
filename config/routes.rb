Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'users/registrations',
                                    omniauth_callbacks: "users/omniauth_callbacks"}

  devise_scope :user do
    authenticated :user do
      root to: 'posts#index', as: :authenticated_root
    end
    unauthenticated :user do
      root to: 'users/registrations#new', as: :unauthenticated_root
    end
  
  end

  resources :users
  resources :friend_requests, only: [:create, :destroy, :update]
  resources :posts
  resources :comments, only: [:create, :destroy]
  resources :likes, only: :create
end
