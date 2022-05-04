# frozen_string_literal: true

class Web::Admin::CategoriesController < Web::Admin::ApplicationController
  after_action :verify_authorized

  def index
    return if redirected_to_root_path_because_not_authorized?

    @categories = Category.order(id: :asc).page(params[:page])
  end

  def new
    return if redirected_to_root_path_because_not_authorized?

    @category = Category.new
  end

  def create
    return if redirected_to_root_path_because_not_authorized?

    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path, notice: t('.success')
    else
      render :new, alert: t('.failure')
    end
  end

  def edit
    return if redirected_to_root_path_because_not_authorized?

    @category = Category.find(params[:id])
  end

  def update
    return if redirected_to_root_path_because_not_authorized?

    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to admin_categories_path, notice: t('.success')
    else
      render :edit, alert: t('.failure')
    end
  end

  def destroy
    return if redirected_to_root_path_because_not_authorized?

    @category = Category.find(params[:id])
    if @category.bulletins.empty?
      @category.delete
      redirect_to admin_categories_path, notice: t('.success')
    else
      redirect_to admin_categories_path, alert: t('.failure')
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
