class CreateIllustrationModels < ActiveRecord::Migration[5.2]
  def change
    create_table :illustration_models do |t|
      t.string :name
      t.timestamps
    end
  end
end
