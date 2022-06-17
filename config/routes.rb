# frozen_string_literal: true

Rails.application.routes.draw do
  get 'user_wallet/available'
  get 'health_check/status'
  post 'auth/sign_in', to: 'auth#sign_in'
  post 'auth/sign_up', to: 'auth#sign_up'
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
