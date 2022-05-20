# frozen_string_literal: true

class Web::ProfileController < ApplicationController
  after_action :verify_authorized

  def show
    authorize :bulletin, :profile?
    @q = current_user.bulletins.ransack(params[:q])
    @bulletins = @q.result.order(created_at: :desc).page(params[:page])
  end
end
