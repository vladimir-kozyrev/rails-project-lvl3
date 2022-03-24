# frozen_string_literal: true

module Web
  class BulletinsController < ApplicationController
    after_action :verify_authorized, except: %i[index]

    def index
      @bulletins = Bulletin.all.order(created_at: :desc)
    end

    def show; end

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

    def edit; end

    def update; end

    def to_moderate; end

    def archive; end

    def admin_moderate
      @bulletins = Bulletin.all
      authorize @bulletins
    end

    def admin_index
      @bulletins = Bulletin.all
      authorize @bulletins
    end

    def profile
      @bulletins = Bulletin.where(user_id: current_user.id)
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
