# frozen_string_literal: true

module AuthConcern
  extend ActiveSupport::Concern

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user_admin?
    user_not_authorized unless current_user&.admin?
  end
end
