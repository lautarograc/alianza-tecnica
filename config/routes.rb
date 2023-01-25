# frozen_string_literal: true

Rails.application.routes.draw do
  resources :events
  resources :aliadas
  post '/events/:id/assign_event', to: 'assign_event#assign_event'
  post '/events/:id/unassign_event', to: 'assign_event#unassign_event'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
