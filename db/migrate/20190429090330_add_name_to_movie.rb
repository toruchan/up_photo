class AddNameToMovie < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :name, :string, null: false, after: :id
  end
end
