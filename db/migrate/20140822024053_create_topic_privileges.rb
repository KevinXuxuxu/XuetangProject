class CreateTopicPrivileges < ActiveRecord::Migration
  def change
    create_table :topic_privileges do |t|
      t.references :user, index: true
      t.references :topic, index: true
      t.string :mode

      t.timestamps
    end
  end
end
