class CreatePlans < ActiveRecord::Migration[5.2]
  def change
    create_table :plans do |t|
      t.string :name, null: false
      t.integer :period, null: false
      t.integer :limit_of_image, null: false
      t.integer :limit_of_illustration, null: false
      t.integer :limit_of_movie, null: false
      t.integer :price, null: false
      t.timestamps
    end
  end
end
