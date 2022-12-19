Rails.application.routes.draw do
  resources :department_practitioners
  resources :departments
  resources :practitioner_profiles
  resources :messages
  resources :appointments
  resources :patient_profiles
  resources :practitioners
  resources :shopping_carts
  resources :products
  resources :orders
  resources :users
  resources :payments
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
