class AddParentToTopics < ActiveRecord::Migration
  def change
    add_reference :topics, :parent, index: true
  end
end
