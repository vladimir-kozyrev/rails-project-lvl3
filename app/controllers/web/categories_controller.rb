# frozen_string_literal: true

module Web
  class CategoriesController < ApplicationController
    after_action :verify_authorized

    def index
      @categories = Category.all
      authorize @categories
    end

    def new
      @category = Category.new
      authorize @category
    end

    def create
      @category = Category.new(category_params)
      authorize @category
      if @category.save
        redirect_to admin_categories_path, notice: 'Successfully created the category'
      else
        render :new, alert: 'Failed to create the category'
      end
    end

    def edit
      @category = Category.find(params[:id])
      authorize @category
    end

    def update
      @category = Category.find(params[:id])
      authorize @category
      if @category.update(category_params)
        redirect_to admin_categories_path, notice: 'Successfully updated the category'
      else
        render :edit, alert: 'Failed to update the category'
      end
    end

    def destroy
      @category = Category.find(params[:id])
      authorize @category
      @category.delete
      redirect_to admin_categories_path, notice: 'The category was deleted'
    end

    private

    def category_params
      params.require(:category).permit(:name)
    end
  end
end
