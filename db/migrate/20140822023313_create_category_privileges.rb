class CreateCategoryPrivileges < ActiveRecord::Migration
  def change
    create_table :category_privileges do |t|
      t.references :user, index: true
      t.references :category, index: true
      t.string :mode

      t.timestamps
    end
  end
end
