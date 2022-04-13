class ApplicationController < ActionController::Base
  before_action :set_categories
  before_action :set_plans
  before_action :store_user_location!, if: :storable_location?
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    if resource.instance_of?(User)
      new_test_path
    elsif resource.instance_of?(AdminUser)
      root_path
    end
  end

  private
    def storable_location?
      request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
    end

    def store_user_location!
      store_location_for(:user, request.fullpath)
    end

    def after_sign_in_path_for(resource_or_scope)
      card = Card.where(user_id: current_user.id)
      if card.blank?
        new_card_path
      else
        stored_location_for(resource_or_scope) || super
      end
    end

    def set_categories
      @image_categories = ImageCategory.all
      @illustration_categories = IllustrationCategory.all
      @movie_categories = MovieCategory.all
    end

    def set_plans
      @plans = Plan.all
      gon.plans = @plans
    end
end
