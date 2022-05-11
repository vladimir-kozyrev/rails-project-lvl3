# frozen_string_literal: true

class Web::Admin::ApplicationController < ApplicationController
  before_action :raise_unless_current_user_admin
end
