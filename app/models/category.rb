class Category < ActiveRecord::Base
  belongs_to :parent, :class_name => "Category"
  has_many :children, :foreign_key => "parent_id", :class_name => "Category"
  has_many :articles
  before_destroy :process_sub_cats
  before_create :set_proper_order

  def self.find_top_categories
    result = []
    Category.all.each do |category|
      result << category unless category.parent
    end
    return result
  end

  def self.downward
  end

  def self.upward
  end

  private

  def set_proper_order
    if self.parent
      parent_id = self.parent.id
      tem_size = Category.find(parent_id).children.size
    else
      tem_size = Category.find_top_categories.size
    end
    self.order = tem_size + 1
    return true
  end

  def process_sub_cats
    old_parent = Category.find(self.id).parent
    self.children.each do |child|
      child.parent = old_parent
      child.save
    end
  end
end
