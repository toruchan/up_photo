# coding: utf-8
# frozen_string_literal: true
require "payjp"

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]
  prepend_before_action :check_captcha, only: [:create]
  prepend_before_action :customize_sign_up_params, only: [:create]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    build_resource(sign_up_params)

    resource.plan_id = nil
    resource.save

    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        # respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        # respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end

    if current_user.blank?
      return
    end

    Payjp.api_key = ENV["PAY_JP_SECRET_KEY"]

    token = ""

    begin

      if params[:number].present?
        
        token = Payjp::Token.create(
          {
            :card => {
              :number => params[:number],
              :cvc => params[:cvc],
              :exp_month => params[:exp_month],
              :exp_year => params[:exp_year]
            }
          },
          {
            'X-Payjp-Direct-Token-Generate': 'true'
          } 
        )
      end

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

        plan = Payjp::Plan.retrieve(params[:user][:plan_id])

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
          # redirect_to action: "thanks"
          redirect_to "/card/thanks" and return
        else
          redirect_to "/card/new"
        end
      end
    rescue Payjp::InvalidRequestError => e
      body = e.json_body
      logger.error(body)
      redirect_to "/card/new", alert: '無効なカード情報です'
    rescue Payjp::CardError => e
      body = e.json_body
      logger.error(body)
      redirect_to "/card/new", alert: '無効なカード情報です'
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  def destroy
    super
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    attr = [:email, :password, :password_confirmation, :plan_id]
    devise_parameter_sanitizer.permit(:sign_up, keys: attr)
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    attr = [:email, :password, :password_confirmation, :plan_id]
    devise_parameter_sanitizer.permit(:account_update, keys: attr)
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  private
  
  def customize_sign_up_params
    devise_parameter_sanitizer.permit :sign_up, keys: [:username, :email, :password, :password_confirmation, :remember_me]
  end

  def check_captcha
    self.resource = resource_class.new sign_up_params
    resource.validate
    unless verify_recaptcha(model: resource)
      @plans = Plan.all
      gon.plans = @plans
      
      @image_categories = ImageCategory.all
      @illustration_categories = IllustrationCategory.all
      @movie_categories = MovieCategory.all

      respond_with_navigational(resource) { render :new }
    end
  end
end
