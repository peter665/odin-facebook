Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'users/registrations'}

  devise_scope :user do
    authenticated :user do
      root to: 'posts#index', as: :authenticated_root
    end
    unauthenticated :user do
      root to: 'users/registrations#new', as: :unauthenticated_root
    end
  end

  resources :users, except: [:new, :create]
  resources :friend_requests, only: [:create, :destroy, :update]
  resources :posts
  resources :likes, only: :create
end
