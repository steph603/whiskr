Rails.application.routes.draw do

  resources :addresses
  resources :bookings
  resources :services
  resources :pets
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/checkout', to: 'pages#checkout'
  get '/about', to: 'pages#about'
  get '/find', to: 'pages#find'
  get '/my_services', to: 'services#my_services'
  root to: 'pages#home'

  get 'success/', to: 'bookings#success' 
  
end
