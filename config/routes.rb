Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :developers

  resources :companies do
    resources :jobs, only: [:new, :create]
  end

  resources :jobs, only: [:show, :index, :edit, :update, :destroy] do
    resources :applications, only: [:new, :create]
  end

  resources :applications, only: [:show, :edit, :update, :destroy]
  resources :conversations, only: [:index, :create, :destroy]
  resources :developer_favorites, only: [:index]
  resources :company_favorites, only: [:index]
  resources :skills, only: [:new, :create, :destroy]
end
