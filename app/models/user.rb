class User < ActiveRecord::Base
  #attr_reader :name
  has_many :articles, :foreign_key => "author_id"
  has_many :posts, :foreign_key => "author_id"
  has_many :comments, :foreign_key => "author_id"
  has_many :messages
  has_many :category_privileges
  has_many :topic_privileges

  before_destroy :cleaning_before_destroy

  def find_all_active_messages
    temp = []
    self.messages.each do |message|
      if message.active?
        temp += [message]
      end
    end
    return temp
  end

  private
  def process_privileges
    self.category_privileges.each do |priv|
      priv.destroy
    end
    self.topic_privileges.each do |priv|
      priv.destroy
    end
  end

  def cleaning_before_destroy
    process_privileges
  end
end
