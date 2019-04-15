# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "homepages#index"

  get 'homepages/index'
  get 'passengers/index'
  get 'passengers/show'
  get 'drivers/index'
  get 'drivers/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
