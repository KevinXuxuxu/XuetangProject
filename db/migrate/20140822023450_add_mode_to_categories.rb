class AddModeToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :mode, :string
  end
end
