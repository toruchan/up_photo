class CreateIllustrationIllustrationTags < ActiveRecord::Migration[5.2]
  def change
    create_table :illustration_illustration_tags do |t|
      t.references :illustration, foreign_key: true
      t.references :illustration_tag, foreign_key: true

      t.timestamps
    end
      add_index :illustration_illustration_tags, [:illustration_id, :illustration_tag_id], unique: true, name: 'illustration_illustration_tags_index'

  end
end
