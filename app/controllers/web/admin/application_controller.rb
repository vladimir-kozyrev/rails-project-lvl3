# frozen_string_literal: true

class Web::Admin::ApplicationController < ApplicationController
  before_action :current_user_admin?
end
