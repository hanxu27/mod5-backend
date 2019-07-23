# frozen_string_literal: true

Rails.application.routes.draw do
  resources :pictures, only: [:index]
  resources :trips
  resources :users
  get '/getUser', to: 'users#get_user'

  resources :parks, only: %i[show index]
  get '/parks&search=:query', to: 'parks#index'

  post '/login', to: 'auth#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
