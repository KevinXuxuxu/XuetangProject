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

<<<<<<< HEAD
  def downward
    if self.parent
      bros = self.parent.children
    else
      bros = Category.find_top_categories
    end
    bros.each do |item|
      if item.order == self.order + 1
        item.order = self.order
        self.order = self.order + 1
        item.save
        self.save
      end
    end
=======
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
>>>>>>> master
  end

  def upward
    if self.parent
      bros = self.parent.children
    else
      bros = Category.find_top_categories
    end

    bros.each do |item|
      if item.order == self.order - 1
        item.order = self.order
        self.order = self.order - 1
        item.save
        self.save
      end
    end
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
      parent_id = self.parent.id
      tem_size = Category.find(parent_id).children.size
    else
      tem_size = Category.find_top_categories.size
    end
    self.order = tem_size + 1
    return true
  end

  def process_sub_cats
    destroyed_cat = Category.find(self.id)
    old_parent = destroyed_cat.parent
    old_order = destroyed_cat.order
    if old_parent
      old_parent.children.each do |child|
        if child.order > old_order
          child.order = child.order - 1
          child.save
        end
      end
      tem_order = old_parent.children.size - 1
      self.children.each do |child|
        child.parent = old_parent
        child.order = child.order + tem_order
        child.save
      end
    else
      self.children.each do |child|
        child.parent = nil
        child.save
      end
    end
  end

end
