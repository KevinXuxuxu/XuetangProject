class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :kind
      t.string :url

      t.timestamps
    end
  end
end
