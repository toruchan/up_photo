class Image < ApplicationRecord
  mount_uploader :image, ImageUploader

  has_many :image_image_tags, foreign_key: :image_id, dependent: :destroy
  has_many :image_tags, through: :image_image_tags

  belongs_to :image_category
  belongs_to :image_model
end
