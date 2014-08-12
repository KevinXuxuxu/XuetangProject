class User < ActiveRecord::Base
  #attr_reader :name
  has_many :articles, :foreign_key => "author_id"
  has_many :posts, :foreign_key => "author_id"
  has_many :comments, :foreign_key => "author_id"
end
