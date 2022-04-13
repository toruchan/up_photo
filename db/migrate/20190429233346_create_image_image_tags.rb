class CreateImageImageTags < ActiveRecord::Migration[5.2]
  def change
    create_table :image_image_tags do |t|
      t.references :image, foreign_key: true
      t.references :image_tag, foreign_key: true

      t.timestamps
    end
  end
end
