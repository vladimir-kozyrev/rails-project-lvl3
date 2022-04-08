# frozen_string_literal: true

class Web::Admin::CategoriesController < ApplicationController
  after_action :verify_authorized

  def index
    @categories = Category.order(id: :asc).page(params[:page])
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
      redirect_to admin_categories_path, notice: t('.success')
    else
      render :new, alert: t('.failure')
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
      redirect_to admin_categories_path, notice: t('.success')
    else
      render :edit, alert: t('.failure')
    end
  end

  def destroy
    @category = Category.find(params[:id])
    authorize @category
    @category.delete
    redirect_to admin_categories_path, notice: t('.success')
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
