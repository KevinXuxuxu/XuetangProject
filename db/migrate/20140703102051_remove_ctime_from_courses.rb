class RemoveCtimeFromCourses < ActiveRecord::Migration
  def change
    remove_column :courses, :ctime, :integer
  end
end
