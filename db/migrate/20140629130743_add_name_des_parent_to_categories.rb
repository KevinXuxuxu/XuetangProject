class AddNameDesParentToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :name, :string
    add_column :categories, :description, :string
    add_reference :categories, :parent, index: true
  end
end
