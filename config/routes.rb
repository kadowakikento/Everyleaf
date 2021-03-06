Rails.application.routes.draw do
  resources :labels
  root 'tasks#index'
  resources :tasks
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show, :edit, :update, :destroy]
  namespace :admin do
    resources :users
  end
end
