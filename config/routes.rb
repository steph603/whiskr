Rails.application.routes.draw do

  resources :bookings
  resources :services
  resources :pets
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/about', to: 'pages#about'
  root to: 'pages#home'
end
