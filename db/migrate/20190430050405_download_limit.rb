class DownloadLimit < ActiveRecord::Migration[5.2]
  def change
    create_table :download_limits do |t|
      t.integer :limit_of_image, null: false, default: 0
      t.integer	:limit_of_illustration, null: false, default: 0
      t.integer	:limit_of_movie, null: false, default: 0
      t.timestamps
      t.references :user
    end
  end
end
