class MovieTag < ApplicationRecord

  has_many :movie_movie_tags
  has_many :movies, through: :movie_movie_tags

end
