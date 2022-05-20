# frozen_string_literal: true

module Web
  class BulletinsController < ApplicationController
    before_action :verify_signed_in, only: %i[
      new create
    ]
    after_action :verify_authorized, only: %i[
      show edit update to_moderate archive
    ]

    def index
      @q = Bulletin.ransack(params[:q])
      @bulletins = @q.result.published.order(created_at: :desc).page(params[:page])
    end

    def show
      @bulletin = Bulletin.find(params[:id])
      authorize @bulletin
    end

    def new
      @bulletin = current_user.bulletins.build
    end

    def create
      @bulletin = current_user.bulletins.build(bulletin_params)
      if @bulletin.save
        redirect_to profile_path, notice: t('.success')
      else
        render :new, alert: t('.failure'), status: :unprocessable_entity
      end
    end

    def edit
      @bulletin = Bulletin.find(params[:id])
      authorize @bulletin
    end

    def update
      @bulletin = Bulletin.find(params[:id])
      authorize @bulletin
      if @bulletin.update(bulletin_params)
        redirect_to profile_path, notice: t('.success')
      else
        render :edit, alert: t('.failure'), status: :unprocessable_entity
      end
    end

    def to_moderate
      @bulletin = Bulletin.find(params[:id])
      authorize @bulletin
      if @bulletin.may_to_moderate?
        @bulletin.to_moderate!
        redirect_to profile_path, notice: t('.success')
      else
        redirect_to profile_path, alert: t('.failure')
      end
    end

    def archive
      @bulletin = Bulletin.find(params[:id])
      authorize @bulletin
      if @bulletin.may_archive?
        @bulletin.archive!
        redirect_to profile_path, notice: t('.success')
      else
        redirect_to profile_path, notice: t('.failure')
      end
    end

    private

    def bulletin_params
      params.require(:bulletin).permit(
        :title,
        :description,
        :category_id,
        :image
      )
    end
  end
end
