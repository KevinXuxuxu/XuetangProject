class Post < ActiveRecord::Base
  belongs_to :author, :class_name => "User"
  belongs_to :topic
  has_many :comments

  before_destroy :delete_comments

  private
  def delete_comments
    self.comments.each do |comment|
      comment.delete
    end
  end
end
