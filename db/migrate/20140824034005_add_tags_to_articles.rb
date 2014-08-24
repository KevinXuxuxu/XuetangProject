class AddTagsToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :tags, :has_and_belongs_to_many
  end
end
