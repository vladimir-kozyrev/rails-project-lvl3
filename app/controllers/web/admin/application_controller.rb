# frozen_string_literal: true

class Web::Admin::ApplicationController < ApplicationController
  before_action :authorize_admin
end
