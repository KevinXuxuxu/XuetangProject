class User < ActiveRecord::Base
  has_many :articles, :foreign_key => "author_id"
  has_many :posts, :foreign_key => "author_id"
  has_many :comments, :foreigh_key => "author_id"
end
