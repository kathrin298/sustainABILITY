Rails.application.routes.draw do
  # devise_for :users, controllers: {registrations: 'registrations'}
  devise_for :users, controllers: {registrations: 'registrations', omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: 'companies#index'
  get 'about', to: 'pages#about', as: :about
  get 'dashboard', to: 'pages#dashboard', as: :dashboard
  get 'search', to: 'pages#search', as: :search

  resources :developers do
    resources :developer_skills, only: [:new, :create, :destroy]
  end

  resources :companies do
    resources :jobs, only: [:new, :create]
  end

  resources :jobs, only: [:show, :index, :edit, :update, :destroy] do
    resources :applications, only: [:new, :create]
    resources :questions, only: [:new, :create]
  end

  resources :applications, only: [:show, :update] do
    resources :reviews, only: [:new, :create]
  end


  resources :questions, only: [:edit, :update, :destroy] do
    resources :answers, only: [:update]
  end

  resources :conversations, only: [:index, :create, :destroy]
  resources :developer_favorites, only: [:index]
  resources :company_favorites, only: [:index]
  resources :skills, only: [:new, :create, :destroy]
  resources :answers, only: [:create]
end
