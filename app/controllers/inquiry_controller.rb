# coding: utf-8
class InquiryController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @inquiry = Inquiry.new
  end

  def confirm
    # 入力値のチェック
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.valid?
      # OK。確認画面を表示
      render :action => 'confirm'
    else
      # NG。入力画面を再表示
      render :action => 'index'
    end
  end

  def thanks
    # メール送信
    @inquiry = Inquiry.new(inquiry_params)
    # InquiryMailer.received_email(@inquiry).deliver

    if @inquiry.save
      # 完了画面を表示
      render :action => 'thanks'
    end
  end

  private

  def inquiry_params
    params.require(:inquiry).permit(:name, :email, :detail)
  end
end
