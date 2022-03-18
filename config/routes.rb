# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    root 'bulletins#index'

    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth

    resources :bulletins, only: %i[index new create]

    scope 'admin', as: 'admin' do
      root 'bulletins#moderate'
      get 'bulletins', to: 'bulletins#admin_index', as: :index
      resources :categories, only: %i[index new create edit update destroy]
    end
  end
end
