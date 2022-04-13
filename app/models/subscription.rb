class Subscription < ApplicationRecord

  def self.subscription_update
    Payjp.api_key = ENV.fetch('PAY_JP_SECRET_KEY')
    target = Subscription.where("period < ?",Time.zone.now)
    return if target.blank?

    target.each do |t|
      subscription = Payjp::Subscription.retrieve(t.subscription_id)
      if subscription.status == 'active'
        dl_limit = DownloadLimit.find_by(id: t.user_id)
        if dl_limit.blank?
          subscription.cancel
          t.period = nil
          ActiveRecord::Base.transaction do
            t.save!
          end
          next
        end

        t.period = Time.at(subscription.current_period_end)
        plan = Plan.find(t.plan_id)
        dl_limit.limit_of_image = plan.limit_of_image
        dl_limit.limit_of_illustration = plan.limit_of_illustration
        dl_limit.limit_of_movie = plan.limit_of_movie
        ActiveRecord::Base.transaction do
          t.save!
          dl_limit.save!
        end
      end
    end
  end
end
