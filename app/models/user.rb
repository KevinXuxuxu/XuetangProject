class User < ActiveRecord::Base
  #attr_reader :name
  has_many :articles, :foreign_key => "author_id"
  has_many :posts, :foreign_key => "author_id"
  has_many :comments, :foreign_key => "author_id"
  has_many :messages

  def find_all_active_messages
    temp = []
    self.messages.each do |message|
      if message.active?
        temp += [message]
      end
    end
    return temp
  end
end
