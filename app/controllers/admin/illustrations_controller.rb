# coding: utf-8
class Admin::IllustrationsController < ApplicationController
  def index
    @illustration = Illustration.new
  end

  def create
    @illustration = Illustration.new(illustration_params)

    if @illustration.save
      redirect_to admin_illustrations_path, notice: 'イラストが追加されました'
    end


  end

  private

  def illustration_params
    params[:illustration].permit(
      :illustration
    )
  end
end
