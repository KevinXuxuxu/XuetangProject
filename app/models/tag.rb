class Tag < ActiveRecord::Base
  has_and_belongs_to_many :articles
  has_and_belongs_to_many :posts
  
  def self.getTag(tag_name)
    tag = Tag.find_by_content(tag_name)
    if tag.nil? then tag = Tag.new(:content => tag_name) end
    return tag
  end
end
