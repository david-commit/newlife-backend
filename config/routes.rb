Rails.application.routes.draw do
  post '/signup', to: 'users#create'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  post '/practitioner/login', to: 'practitioner_sessions#create'
  delete '/practitioner/logout', to: 'practitioner_sessions#destroy'

  resources :products, only: [:index]
  resources :messages, only: [:create]
  resources :appointments, only: [:create]
  resources :orders, only: [:create, :update, :destroy]
  resources :payments, only: [:create, :update]

  resources :users, only: [:show] do

    resources :appointments, only: [:index, :show]
    resources :orders, only: [:index, :show]
    resources :payments, only: [:index, :show]

    resources :appointments, only: [:show] do
      resources :messages, only: [:index, :show]
    end
  end
  
  # resources :departments
  # resources :practitioner_profiles
  # resources :messages
  # resources :appointments
  # resources :patient_profiles
  # resources :practitioners
  # resources :shopping_carts
  # resources :products
  # resources :orders
  # resources :users
  # resources :payments
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
