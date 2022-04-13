class CreateMovieMovieTags < ActiveRecord::Migration[5.2]
  def change
    create_table :movie_movie_tags do |t|
      t.references :movie, foreign_key: true
      t.references :movie_tag, foreign_key: true

      t.timestamps
    end
  end
end
