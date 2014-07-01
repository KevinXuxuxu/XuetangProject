class Article < ActiveRecord::Base
  belongs_to :author, :class_name => "User"
  belongs_to :category
  def self.new_with_cat_name params
    p = params.dup
    p[:category] = Category.find_by_name(p[:category])
    Article.new(p)
  end
  def update_with_cat_name params
    p = params.dup
    p[:category] = Category.find_by_name(p[:category])
    update(p)
  end
end
