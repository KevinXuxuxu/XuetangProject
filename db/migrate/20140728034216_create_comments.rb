class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.references :author, index: true
      t.references :post, index: true

      t.timestamps
    end
  end
end
