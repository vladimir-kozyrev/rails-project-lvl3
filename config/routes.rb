# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    root 'bulletin#index'
    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
  end
end
