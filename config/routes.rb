Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: 'registrations'}
  root to: 'companies#index'
  get 'about', to: 'pages#about', as: :about
  get 'dashboard', to: 'pages#dashboard', as: :dashboard
  get 'search', to: 'pages#search', as: :search

  resources :developers do
    resources :developer_skills, only: [:new, :create, :destroy]
    resources :developer_favourites, only: [:create]
  end

  resources :companies do
    resources :jobs, only: [:new, :create]
    resources :company_favourites, only: [:create]
  end

  resources :developer_favourites, only: [:index, :destroy]
  resources :company_favourites, only: [:index, :destroy]

  resources :jobs, only: [:show, :index, :edit, :update, :destroy] do
    resources :applications, only: [:new, :create]
    resources :questions, only: [:new, :create]
    resources :job_skills, only: [:new, :create, :destroy]
  end

  resources :applications, only: [:show, :update] do
    resources :reviews, only: [:new, :create]
  end


  resources :questions, only: [:edit, :update, :destroy] do
    resources :answers, only: [:update]
  end

  resources :conversations, only: [:index, :create, :destroy] do
    resources :messages, only: [:new, :create]
  end

  resources :skills, only: [:new, :create, :destroy]
  resources :answers, only: [:create]
end
