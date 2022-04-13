class MovieMovieTag < ApplicationRecord
  belongs_to :movie
  belongs_to :movie_tag
end
