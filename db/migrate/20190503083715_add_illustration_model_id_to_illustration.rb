class AddIllustrationModelIdToIllustration < ActiveRecord::Migration[5.2]
  def change
    add_reference :illustrations, :illustration_model, index: true
  end
end
