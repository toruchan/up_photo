class Illustration < ApplicationRecord
  mount_uploader :illustration, IllustrationUploader

  has_many :illustration_illustration_tags, foreign_key: :illustration_id, dependent: :destroy
  has_many :illustration_tags, through: :illustration_illustration_tags

  belongs_to :illustration_category
  belongs_to :illustration_model
end
