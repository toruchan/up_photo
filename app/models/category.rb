class Category < ApplicationRecord

  has_many :image_categories
  has_many :images, through: :image_categories

  has_many :illustration_categories
  has_many :illustrations, through: :illustration_categories

  has_many :movie_categories
  has_many :movies, through: :movie_categories

end
