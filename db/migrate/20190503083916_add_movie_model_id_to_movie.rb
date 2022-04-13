class AddMovieModelIdToMovie < ActiveRecord::Migration[5.2]
  def change
    add_reference :movies, :movie_model, index: true
  end
end
