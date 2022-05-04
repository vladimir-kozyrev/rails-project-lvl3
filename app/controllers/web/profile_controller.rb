# frozen_string_literal: true

class Web::ProfileController < ApplicationController
  after_action :verify_authorized

  def profile
    begin
      authorize :bulletin
    rescue Pundit::NotAuthorizedError
      redirect_to root_path, alert: t('.failure')
      return
    end
    @q = Bulletin.ransack(params[:q])
    @bulletins = @q.result.where(user_id: current_user.id).order(created_at: :desc).page(params[:page])
  end
end
