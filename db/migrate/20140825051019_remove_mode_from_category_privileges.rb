class RemoveModeFromCategoryPrivileges < ActiveRecord::Migration
  def change
    remove_column :category_privileges, :mode, :string
  end
end
