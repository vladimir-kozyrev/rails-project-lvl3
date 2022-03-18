# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find(session[:user_id])
  end
end
