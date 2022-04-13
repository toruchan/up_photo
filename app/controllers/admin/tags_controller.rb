# coding: utf-8
class Admin::TagsController < ApplicationController
  def index
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to admin_tags_path, notice: 'タグが追加されました'
    end
  end

  private

  def tag_params
    params[:tag].permit(
      :name
    )
  end
end
