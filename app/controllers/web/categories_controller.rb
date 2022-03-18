# frozen_string_literal: true

module Web
  class CategoriesController < ApplicationController
    def index
      @categories = Category.all
    end

    def new
      @category = Category.new
    end

    def create
      @category = Category.new(category_params)
      if @category.save
        redirect_to admin_categories, notice: 'Successfully created the category'
      else
        render :new, alert: 'Failed to create the category'
      end
    end

    def edit
      @category = Category.find(params[:id])
    end

    def update
      @category = Category.find(params[:id])
      if @category.update(category_params)
        redirect_to admin_categories, notice: 'Successfully updated the category'
      else
        render :edit, alert: 'Failed to update the category'
      end
    end

    def destroy
      @category = Category.find(params[:id])
      @category.delete
      redirect_to admin_categories, notice: 'The category was deleted'
    end

    private

    def category_params
      params.require(:category).permit(:name)
    end
  end
end
