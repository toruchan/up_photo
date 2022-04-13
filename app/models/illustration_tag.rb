class IllustrationTag < ApplicationRecord
  has_many :illustration_illustration_tags
  has_many :illustrations, through: :illustration_illustration_tags
end
