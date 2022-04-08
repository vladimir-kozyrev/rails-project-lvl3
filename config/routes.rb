# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :web do
    get 'profile/show'
  end
  scope module: :web do
    root 'bulletins#index'

    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth

    resources :bulletins, only: %i[index show new create edit update]
    get 'profile', to: 'profile#profile', as: :profile
    patch 'bulletins/:id/to_moderate', to: 'bulletins#to_moderate', as: :to_moderate_bulletin
    patch 'bulletins/:id/archive', to: 'bulletins#archive', as: :archive_bulletin

    scope 'admin', module: :admin, as: :admin do
      root 'bulletins#moderate'
      resources :bulletins, only: :index do
        member do
          patch 'publish'
          patch 'reject'
          patch 'archive'
        end
      end
      resources :categories, only: %i[index new create edit update destroy]
    end
  end
end
