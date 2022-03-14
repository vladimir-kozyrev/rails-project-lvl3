# frozen_string_literal: true

module Web
  class AuthController < ApplicationController
    # skip_before_action :verify_authenticity_token, only: :create

    def callback
      @user = User.find_or_create_from_auth(auth_hash)
      if @user
        session[:user_id] = @user.id
        redirect_to root_path, notice: 'Signed in!'
      else
        redirect_to root_path, alert: 'Could not sign in'
      end
    end

    private

    def auth_hash
      request.env['omniauth.auth']
    end
  end
end
