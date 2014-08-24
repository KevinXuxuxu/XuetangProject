class AddModeToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :mode, :string
  end
end
