# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    root 'bulletins#index'

    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    delete 'auth/logout', to: 'auth#destroy', as: :auth_destroy

    resources :bulletins, only: %i[index show new create edit update]
    get 'profile', to: 'bulletins#profile', as: :profile
    patch 'bulletins/:id/to_moderate', to: 'bulletins#to_moderate', as: :to_moderate_bulletin
    patch 'bulletins/:id/archive', to: 'bulletins#archive', as: :archive_bulletin

    scope 'admin', as: 'admin' do
      root 'admin#moderate', as: :moderate
      get 'bulletins', to: 'admin#bulletins', as: :bulletins
      patch 'bulletins/:id/publish', to: 'admin#publish', as: :publish
      patch 'bulletins/:id/reject', to: 'admin#reject', as: :reject
      patch 'bulletins/:id/archive', to: 'admin#archive', as: :archive
      resources :categories, only: %i[index new create edit update destroy]
    end
  end
end
