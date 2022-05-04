# frozen_string_literal: true

class Web::Admin::BulletinsController < Web::Admin::ApplicationController
  after_action :verify_authorized

  def moderate
    return if redirected_to_root_path_because_not_authorized?

    @bulletins = Bulletin.where(state: 'under_moderation')
  end

  def index
    return if redirected_to_root_path_because_not_authorized?

    @q = Bulletin.ransack(params[:q])
    @bulletins = @q.result.order(created_at: :desc).page(params[:page])
  end

  def publish
    return if redirected_to_root_path_because_not_authorized?

    @bulletin = Bulletin.find(params[:id])
    @bulletin.publish!
    redirect_to admin_root_path, notice: t('.success')
  end

  def reject
    return if redirected_to_root_path_because_not_authorized?

    @bulletin = Bulletin.find(params[:id])
    @bulletin.reject!
    redirect_to admin_root_path, notice: t('.success')
  end

  def archive
    return if redirected_to_root_path_because_not_authorized?

    @bulletin = Bulletin.find(params[:id])
    @bulletin.archive!
    redirect_to admin_root_path, notice: t('.success')
  end
end
