class AddMivieCategoryIdToMovie < ActiveRecord::Migration[5.2]
  def change
    add_reference :movies, :movie_category, index: true
  end
end
