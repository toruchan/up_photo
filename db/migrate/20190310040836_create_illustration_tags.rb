class CreateIllustrationTags < ActiveRecord::Migration[5.2]
  def change
    create_table :illustration_tags do |t|
      t.string :name
      t.timestamps
    end
  end
end
