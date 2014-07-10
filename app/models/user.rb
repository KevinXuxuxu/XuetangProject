class User < ActiveRecord::Base
  has_many :articles, :foreign_key => "author_id"
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
