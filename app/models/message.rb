class Message < ActiveRecord::Base
  belongs_to :user
  def active?
    return self.status == "active"
  end
end
