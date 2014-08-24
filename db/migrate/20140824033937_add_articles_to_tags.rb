class AddArticlesToTags < ActiveRecord::Migration
  def change
    add_column :tags, :articles, :has_and_belongs_to_many, :join_table => "articles_tags"
  end
end
