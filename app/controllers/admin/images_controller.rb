# coding: utf-8
class Admin::ImagesController < ApplicationController

  def index
    @image = Image.new
  end

  def create
    @image = Image.new(image_params)
    # s3 = Aws::S3::Resource.new
    # bucket = s3.bucket(ENV.fetch('AWS_S3_BUCKET'))

    # image = image_params[:image]
    # image_name = image.original_filename
    # s3_path = "uploads/#{Date.today}/#{Time.now.to_s(:file_name)}_#{image_name}"
    # object = bucket.object(s3_path)
    # object.put(body: image)
    # @image.file_name = image_name
    # @image.path = s3_path
    if @image.save
      redirect_to admin_images_path, notice: 'imageが追加されました'
    end
  end

  private

  def image_params
    params[:image].permit(
      :image
    )
  end
end
