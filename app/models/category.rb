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

  def find_sub_categories
    sub_categories = []
    Category.all.each do |category|
      if category.parent == self
        sub_categories += [category]
      end
    end
    return sub_categories
  end

  def self.downward
  end

  def self.upward
  end

  def self.new_with_parent_name params
    p = params.dup
    p[:parent] = Category.find_by_name(p[:parent])
    Category.new(p)
  end

  def update_with_patent_name params
    p = params.dup
    p[:parent] = Category.find_by_name(p[:parent])
    update(p)
  end

  private

  def set_proper_order
    if self.parent
      tem_size = self.parent.children.size
    else
      tem_size = Category.find_top_categories.size
    end
    self.order = tem_size + 1
  end

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
