# coding: utf-8
require "payjp"
class CardController < ApplicationController

  def new
    #card = Card.where(user_id: current_user.id)
    card = Card.where(user_id: current_user.id)
    redirect_to action: "show" if card.exists?
  end

  def pay #payjpとCardのデータベース作成を実施します。
    Payjp.api_key = ENV["PAY_JP_SECRET_KEY"]

    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
      description: '登録テスト', #なくてもOK
      email: current_user.email, #なくてもOK
      card: params['payjp-token'],
      metadata: {user_id: current_user.id}
      ) #念の為metadataにuser_idを入れましたがなくてもOK
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)

      plan = Payjp::Plan.retrieve(params[:plan_id])

      if plan.interval == 'month'
        period = Time.zone.now + 1.month
      elsif plan.interval == 'year'
        period = Time.zone.now + 1.year
      else
        period = nil
      end

      subscription = Payjp::Subscription.create(
        plan: plan.id,
        customer: customer.id
      )

      @subscription = Subscription.new(user_id: current_user.id, plan_id: plan.id, subscription_id: subscription.id, period: period)

      @plan = Plan.find(plan.id)
      dl_limit = DownloadLimit.new
      dl_limit.limit_of_image = @plan.limit_of_image
      dl_limit.limit_of_illustration = @plan.limit_of_illustration
      dl_limit.limit_of_movie = @plan.limit_of_movie
      dl_limit.user_id = current_user.id

      @user = User.find(current_user.id)
      @user.plan_id = @plan.id
      
      if @card.save && @subscription.save && dl_limit.save && @user.save
        redirect_to action: "thanks"
      else
        redirect_to action: "pay"
      end
    end
  end

  def delete #PayjpとCardデータベースを削除します
    card = Card.where(user_id: current_user.id).first
    if card.blank?
    else
      Payjp.api_key = ENV["PAY_JP_SECRET_KEY"]
      subscription = Subscription.where(user_id: current_user.id).first
      customer = Payjp::Customer.retrieve(card&.customer_id)
      dl_limit = DownloadLimit.find_by(user_id: current_user.id)
      user = User.find(current_user.id)
      user.plan_id = nil
      customer.delete if customer.present?
      card.delete if card.present?
      subscription.delete if subscription.present?
      dl_limit.delete if dl_limit.present?
      user.save
    end
      redirect_to action: "new"
  end

  def show #Cardのデータpayjpに送り情報を取り出します
    card = Card.where(user_id: current_user.id).first
    if card.blank?
      redirect_to action: "new" 
    else
      Payjp.api_key = ENV["PAY_JP_SECRET_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end

  def thanks
    render "thanks"
  end
end
