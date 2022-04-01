# frozen_string_literal: true

module Web
  class AdminController < ApplicationController
    after_action :verify_authorized

    def moderate
      @bulletins = Bulletin.where(state: 'under_moderation')
      authorize :admin, :moderate?
    end

    def bulletins
      @q = Bulletin.ransack(params[:q])
      @bulletins = @q.result.order(created_at: :desc).page(params[:page])
      authorize :admin
    end

    def publish
      @bulletin = Bulletin.find(params[:id])
      authorize @bulletin
      @bulletin.publish!
      redirect_to admin_moderate_path
    end

    def reject
      @bulletin = Bulletin.find(params[:id])
      authorize @bulletin
      @bulletin.reject!
      redirect_to admin_moderate_path
    end

    def archive
      @bulletin = Bulletin.find(params[:id])
      authorize @bulletin
      @bulletin.archive!
      redirect_to admin_moderate_path
    end
  end
end
