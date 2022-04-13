class AddNameToimage < ActiveRecord::Migration[5.2]
  def change
    add_column :images, :name, :string, null: false, after: :id
  end
end
