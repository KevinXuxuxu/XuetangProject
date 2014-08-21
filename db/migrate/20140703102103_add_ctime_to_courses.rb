class AddCtimeToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :ctime, :string
  end
end
