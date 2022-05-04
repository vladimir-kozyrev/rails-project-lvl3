# frozen_string_literal: true

class Web::Admin::ApplicationController < ApplicationController
  private

  def redirected_to_root_path_because_not_authorized?
    authorize :admin
    false
  rescue Pundit::NotAuthorizedError
    redirect_to root_path, alert: t('en.web.auth.not_authorized')
    true
  end
end
