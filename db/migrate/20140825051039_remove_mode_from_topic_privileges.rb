class RemoveModeFromTopicPrivileges < ActiveRecord::Migration
  def change
    remove_column :topic_privileges, :mode, :string
  end
end
