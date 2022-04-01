# frozen_string_literal: true

module Web
  class BulletinsController < ApplicationController
    after_action :verify_authorized, except: %i[index]

    def index
      @q = Bulletin.ransack(params[:q])
      @bulletins = @q.result.where(state: 'published').order(created_at: :desc).page(params[:page])
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
        redirect_to profile_path, notice: 'Bulletin was successfully updated.'
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
      redirect_to profile_path
    end

    def profile
      @q = Bulletin.ransack(params[:q])
      @bulletins = @q.result.where(user_id: current_user.id).order(created_at: :desc).page(params[:page])
      authorize @bulletins
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
