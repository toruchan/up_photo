class ImageTag < ApplicationRecord

  has_many :image_image_tags
  has_many :images, through: :image_image_tags
end
