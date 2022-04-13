class AddImageCategoryIdToImage < ActiveRecord::Migration[5.2]
  def change
    add_reference :images, :image_category, index: true
  end
end
