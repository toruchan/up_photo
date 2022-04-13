class Movie < ApplicationRecord
  mount_uploader :movie, MovieUploader

  has_many :movie_movie_tags, foreign_key: :movie_id, dependent: :destroy
  has_many :movie_tags, through: :movie_movie_tags

  belongs_to :movie_category
  belongs_to :movie_model
end
