class Topic < ActiveRecord::Base
  belongs_to :parent, :class_name => "Topic"
  has_many :children, :foreign_key => "parent_id", :class_name => "Topic"
  has_many :privileges, :foreign_key => "topic_id", :class_name => "TopicPrivilege"
  has_many :posts
  before_create :set_proper_order
  before_destroy :cleaning_before_destroy

  def validate priv_level, tem_user
    if self.mode == 'private'
      self.privileges.each do |priv|
        if priv.user == tem_user && priv.mode >= priv_level
          return true
        end
      end
      return false
    else
      if self.parent
        return self.parent.validate(priv_level, tem_user)
      else
        return true
      end
    end
  end

  # TODO: Add relevant controller, view and route
  def generate_privileges user_list, priv_level
    if self.mode == 'public'
      return false
    end
    user_list.each do |user|
      TopicPrivilege.create(user: user, category: self, mode: priv_level)
    end
    return true
  end

  def self.find_top_topics
    result = []
    Topic.all.each do |topic|
      result += [topic] unless topic.parent
    end
    return result
  end

  def downward
    bros = self.get_bros

    self_order = self.order
    bros.each do |item|
      if item.order == self_order + 1
        item.order = self_order
        self.order = self_order + 1
        item.save
        self.save
      end
    end
  end

  def upward
    bros = self.get_bros

    self_order = self.order
    bros.each do |item|
      if item.order == self_order - 1
        item.order = self_order
        self.order = self_order - 1
        item.save
        self.save
      end
    end
  end

  def self.new_with_parent_name params
    p = params.dup
    p[:parent] = Topic.find_by_name(p[:parent])
    Topic.new(p)
  end

  def update_with_parent_name params
    p = params.dup
    p[:parent] = Topic.find_by_name(p[:parent])
    update(p)
  end

  def get_bros
    if self.parent
      bros = Topic.find(self.parent.id).children
    else
      bros = Topic.find_top_topics
    end
    return bros
  end


  private

  def set_proper_order
    bros = self.get_bros
    self.order = bros.size + 1
    return true
  end

  def process_sub_topics
    destroyed_topic = Topic.find(self.id)
    old_parent = destroyed_topic.parent
    old_order = destroyed_topic.order
    if old_parent
      old_parent.children.each do |bro|
        if bro.order > old_order
          bro.order = bro.order - 1
          bro.save
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

  def process_privileges
    self.privileges.each do |privilege|
      privilege.destroy
    end
  end

  def cleaning_before_destroy
    # This is a wrap up for before destroy functions
    process_sub_topics
    process_privileges
  end
end
