class AddImageModelIdToImage < ActiveRecord::Migration[5.2]
  def change
    add_reference :images, :image_model, index: true
  end
end
