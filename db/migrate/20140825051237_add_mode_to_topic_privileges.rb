class AddModeToTopicPrivileges < ActiveRecord::Migration
  def change
    add_column :topic_privileges, :mode, :integer
  end
end
