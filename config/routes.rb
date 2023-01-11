Rails.application.routes.draw do
  resources :responses
  post "/signup", to: "users#create"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/me", to: "users#show"

  post "/practitioner/signup", to: "practitioners#create"
  post "/practitioner/login", to: "practitioner_sessions#create"
  delete "/practitioner/logout", to: "practitioner_sessions#destroy"

  post "admin/signup", to: "admins#create"
  post "admin/login", to: "admin_sessions#create"
  delete "admin/logout", to: "admin_sessions#destroy"
  delete "admin/delete_account", to: "admins#destroy"

  resources :products, only: [:index, :show]
  resources :messages, only: [:create]
  resources :appointments, only: [:create, :destroy, :update]
  resources :orders, only: [:create, :update, :destroy]
  resources :payments, only: [:create, :update, :destroy, :index, :show]
  resources :shopping_carts, only: [:create, :update, :destroy, :show]
  resources :departments, only: [:index, :show]
  resources :patient_profiles, only: [:create, :index, :show, :update, :destroy]
  resources :practitioner_profiles, only: [:create, :index, :show, :update, :destroy]
  resources :reviews, only: [:create, :index, :show, :update, :destroy]
  resources :side_effects, only: [:create, :index, :show, :update, :destroy]
  resources :dosage_considerations, only: [:create, :index, :show, :update, :destroy]
  resources :users, only: [:destroy]

  resources :admins, only: [:show] do
    resources :products, only: [:create, :index, :show, :update, :destroy]
  end

  resources :users, only: [:show] do
    resources :appointments, only: %i[index show]
    resources :orders, only: %i[index show]
    resources :shopping_carts, only: %i[show index]

    resources :appointments, only: [:show] do
      resources :messages, only: %i[index show]
    end
  end

  resources :practitioners, only: [:show] do
    resources :appointments, only: %i[index show]
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
