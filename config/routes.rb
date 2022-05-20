# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    root 'bulletins#index'

    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    delete 'sign_out', to: 'auth#sign_out'

    resources :bulletins, only: %i[index show new create edit update] do
      member do
        patch 'to_moderate'
        patch 'archive'
      end
    end

    get 'profile', to: 'profile#show', as: :profile

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
