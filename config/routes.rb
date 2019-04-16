# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'homepages#homepages'

  resources :passengers
  resources :drivers
  resources :trips
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
