# frozen_string_literal: true

module Web::BulletinsHelper
  def user_signed_in?
    session[:user_id]
  end
end
