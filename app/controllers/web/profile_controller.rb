# frozen_string_literal: true

class Web::ProfileController < ApplicationController
  after_action :verify_authorized

  def profile
    @q = Bulletin.ransack(params[:q])
    @bulletins = @q.result.where(user_id: current_user.id).order(created_at: :desc).page(params[:page])
    authorize @bulletins
  end
end
