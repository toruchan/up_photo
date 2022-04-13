# coding: utf-8
class Admin::CategoriesController < ApplicationController
  def index
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path, notice: 'カテゴリーが追加されました'
    end
  end

  private

  def category_params
    params[:category].permit(
      :name
    )
  end
end
