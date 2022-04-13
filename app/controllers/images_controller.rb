class ImagesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :tag]
  before_action :set_image, only: [:show]
  before_action :set_category, only: [:index]
  before_action :set_similar_image, only: [:show]
  before_action :set_same_model_image, only: [:show]
  before_action :set_tag, only: [:index, :show, :tag]

  PER = 9

  def index
    @images = Image.where(image_category_id: params[:format].to_i).page(params[:page]).per(PER)
  end

  def show

  end

  def tag
    @tag = ImageTag.find(params[:tag_id])
    @category = ImageCategory.find_by(id: params[:category_id])
    @images = Image.where(id: ImageImageTag.where(image_tag_id: @tag.id).pluck(:image_id)).page(params[:page]).per(PER)
    @breadcrumbs = {}
    @breadcrumbs['tag'] = @tag
    @breadcrumbs['category'] = @category
  end

  def download
    @image = Image.find(params[:image_id])
    filepath = @image.image.current_path
    data = open(@image.image.url)
    send_data(data.read, filename: @image.image_identifier, type: @image.image.content_type)
    user = current_user
    @limit = user.download_limit
    @limit.limit_of_image -= 1
    @limit.save
  end

  private

  def set_image
    @image = Image.find(params[:id])
  end

  def set_tag
    @tags = ImageTag.all
  end

  def set_category
    @image_category = ImageCategory.find(params[:format])
  end

  def set_similar_image
    @similar_image = Image.where(image_category_id: @image.image_category_id).where.not(id: @image.id)
  end

  def set_same_model_image
    @images_of_same_model = Image.where(image_model_id: @image.image_model_id).where.not(id: @image.id)
  end  
end
