class AddModeToCategoryPrivileges < ActiveRecord::Migration
  def change
    add_column :category_privileges, :mode, :integer
  end
end
