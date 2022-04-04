# frozen_string_literal: true

class Web::Admin::BulletinsController < ApplicationController
  after_action :verify_authorized

  def moderate
    @bulletins = Bulletin.where(state: 'under_moderation')
    authorize :admin
  end

  def bulletins
    @q = Bulletin.ransack(params[:q])
    @bulletins = @q.result.order(created_at: :desc).page(params[:page])
    authorize :admin
  end

  def publish
    @bulletin = Bulletin.find(params[:id])
    authorize :admin
    @bulletin.publish!
    redirect_to admin_moderate_path
  end

  def reject
    @bulletin = Bulletin.find(params[:id])
    authorize :admin
    @bulletin.reject!
    redirect_to admin_moderate_path
  end

  def archive
    @bulletin = Bulletin.find(params[:id])
    authorize :admin
    @bulletin.archive!
    redirect_to admin_moderate_path
  end
end
