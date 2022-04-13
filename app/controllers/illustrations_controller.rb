class IllustrationsController < ApplicationController
  before_action :set_illustration, only: [:show]
  before_action :set_category, only: [:index]
  before_action :set_similar_illustration, only: [:show]
  before_action :set_same_model_illustration, only: [:show]
  before_action :set_tag, only: [:index, :show, :tag]
  before_action :authenticate_user!, except: [:index, :show, :tag]

  PER = 9

  def index
    @illustrations = Illustration.where(illustration_category_id: params[:format].to_i).page(params[:page]).per(PER)
  end


  def tag
    @tag = IllustrationTag.find(params[:tag_id])
    @category = IllustrationCategory.find_by(id: params[:category_id])
    @illustrations = Illustration.where(id: IllustrationIllustrationTag.where(illustration_tag_id: @tag.id).pluck(:illustration_id)).page(params[:page]).per(PER)
    @breadcrumbs = {}
    @breadcrumbs['tag'] = @tag
    @breadcrumbs['category'] = @category
  end

  def download
    @illustration = Illustration.find(params[:illustration_id])
    filepath = @illustration.illustration.current_path
    data = open(@illustration.illustration.url)
    send_data(data.read, filename: @illustration.illustration_identifier, type: @illustration.illustration.content_type)
    user = current_user
    @limit = user.download_limit
    @limit.limit_of_illustration -= 1
    @limit.save
  end

  private

  def set_illustration
    @illustration = Illustration.find(params[:id])
  end

  def set_tag
    @tags = IllustrationTag.all
  end

  def set_category
    @illustration_category = IllustrationCategory.find(params[:format])
  end

  def set_similar_illustration
    @similar_illustration = Illustration.where(illustration_category_id: @illustration.illustration_category_id).where.not(id: @illustration.id)
  end

  def set_same_model_illustration
    @illustrations_of_same_model = Illustration.where(illustration_model_id: @illustration.illustration_model_id).where.not(id: @illustration.id)
  end

end
