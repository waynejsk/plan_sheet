Rails.application.routes.draw do
  namespace :admin do
    resources :users, only: [:index]
  end

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/signup', to: 'users#new'
  resources :users, only: [:create, :show]
  
  resources :meetings do
    member do
      post :send_email
    end
  end

  root 'meetings#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
