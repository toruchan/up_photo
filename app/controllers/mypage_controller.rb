class MypageController < ApplicationController
  before_action :authenticate_user!, except: [:complete]

  def index
    @plan = Plan.find_by(id: current_user.plan_id)

    if @plan.nil?
      redirect_to '/card/new'
    end
  end

  def destroy
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
    current_user.destroy
    redirect_to action: :complete
  end

  def complete
    
  end
end
