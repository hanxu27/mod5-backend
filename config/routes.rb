# frozen_string_literal: true

Rails.application.routes.draw do
  resources :pictures, only: [:index]
  resources :trips
  resources :users
  get '/getUser', to: 'users#show_user'

  # get '/parks&q=:query                                                                                                                                                                                                                                                                                                                                                                              ``', to: 'park#index'
  resources :parks, only: %i[show index]

  post '/login', to: 'auth#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
