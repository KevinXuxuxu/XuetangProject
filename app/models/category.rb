class Category < ActiveRecord::Base
  belongs_to :parent, :class_name => "Category"
  has_many :children, :foreign_key => "parent_id", :class_name => "Category"
  has_many :articles
  before_destroy :process_sub_cats

  def self.find_top_categories
    result = []
    Category.all.each do |category|
      result << category unless category.parent
    end
    return result
  end

  private

  def process_sub_cats
    if self.children.size != 0
      old_parent = self.parent
      self.children.each do |child|
        child.parent = old_parent
        child.save
      end
    end
  end
end
