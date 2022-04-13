class AddNameToIllustration < ActiveRecord::Migration[5.2]
  def change
    add_column :illustrations, :name, :string, null: false, after: :id
  end
end
