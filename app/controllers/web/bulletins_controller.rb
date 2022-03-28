# frozen_string_literal: true

module Web
  class BulletinsController < ApplicationController
    after_action :verify_authorized, except: %i[index]

    def index
      @q = Bulletin.ransack(params[:q])
      @bulletins = @q.result.where(state: 'published').order(created_at: :desc)
    end

    def show
      @bulletin = Bulletin.find(params[:id])
      authorize @bulletin
    end

    def new
      user = User.find(session[:user_id])
      @bulletin = user.bulletins.build
      authorize @bulletin
    end

    def create
      user = User.find(session[:user_id])
      @bulletin = user.bulletins.build(bulletin_params)
      authorize @bulletin
      if @bulletin.save
        redirect_to bulletins_path, notice: 'The bulletin was successfully created'
      else
        render :new, alert: 'Failed to create the bulletin'
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
        redirect_to bulletin_path, notice: 'Bulletin was successfully updated.'
      else
        render :edit
      end
    end

    def to_moderate
      @bulletin = Bulletin.find(params[:id])
      authorize @bulletin
      @bulletin.to_moderate!
      redirect_to profile_path
    end

    def archive
      @bulletin = Bulletin.find(params[:id])
      authorize @bulletin
      @bulletin.archive!
      if current_user.admin?
        redirect_to admin_index_path
      else
        redirect_to profile_path
      end
    end

    def profile
      @bulletins = Bulletin.where(user_id: current_user.id)
      authorize @bulletins
    end

    def admin_index
      @bulletins = Bulletin.where(state: 'under_moderation')
      authorize @bulletins
    end

    def admin_moderate
      @bulletins = Bulletin.all
      authorize @bulletins
    end

    def admin_publish
      @bulletin = Bulletin.find(params[:id])
      authorize @bulletin
      @bulletin.publish!
      redirect_to admin_index_path
    end

    def admin_reject
      @bulletin = Bulletin.find(params[:id])
      authorize @bulletin
      @bulletin.reject!
      redirect_to admin_index_path
    end

    private

    def bulletin_params
      params.require(:bulletin).permit(
        :category,
        :title,
        :description,
        :category_id,
        :image
      )
    end
  end
end
