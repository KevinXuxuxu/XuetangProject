class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :content

      t.timestamps
    end
    add_index :tags, :content
  end
end
