class AddIllustrationCategoryIdToIllustration < ActiveRecord::Migration[5.2]
  def change
    add_reference :illustrations, :illustration_category, index: true
  end
end
