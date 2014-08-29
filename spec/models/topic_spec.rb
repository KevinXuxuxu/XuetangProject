require 'rails_helper'

RSpec.describe Topic, :type => :model do
  describe "subtopic relations" do
    before :each do
      @empty = Topic.create(name: "empty")
      @parent = Topic.create(name: "parent")
      @sub_topic_1 = Topic.create(name: "sub_1", parent: @parent)
      @sub_topic_2 = Topic.create(name: "sub_2", parent: @parent)
    end
    it "should return empty when no children" do
      expect(@empty.children).to eq([])
    end
    it "should return the array of children" do
      @parent = Topic.find(@parent.id)
      expect(@parent.children).to eq([@sub_topic_1, @sub_topic_2])
    end
    it "should return nil when no parent" do
      expect(@parent.parent).to eq(nil)
    end
    it "should return the parent" do
      expect(@sub_topic_1.parent).to eq(@parent)
    end
  end

  describe 'validate' do
    before :each do
      @topic_1 = Topic.create(mode: "public")
      @topic_2 = Topic.create(mode: "private")
      @topic_3 = Topic.create(mode: "public", parent: @topic_2)
      @topic_4 = Topic.create(mode: "private", parent: @topic_2)
      @user_1 = User.create()
      @user_2 = User.create()
      @priv_1 = TopicPrivilege.create(user: @user_1, topic: @topic_2, mode: 2)
      @priv_2 = TopicPrivilege.create(user: @user_1, topic: @topic_4, mode: 2)
    end
    it 'should block the user if not authorized' do
      result = @topic_2.validate 1, @user_2
      expect(result).to eq(false)
    end
    it 'should return true if authorized' do
      result = @topic_2.validate 1, @user_1
      expect(result).to eq(true)
    end
    it 'should check parent topic if temporal topic is public' do
      expect(@topic_2).to receive(:validate).with(1, @user_1).and_return(true)
      result = @topic_3.validate 1, @user_1
      expect(result).to eq(true)
    end
    it 'should not check parent topic if temporal topic is private' do
      expect(@topic_2).not_to receive(:validate)
      @topic_4.validate 1, @user_1
    end
    it 'should not block the user if top topic is public' do
      result = @topic_1.validate 1, @user_2
      expect(result).to eq(true)
    end
  end

  describe "find_top_topics" do
    it "should find all top topics" do
      @top_1 = FactoryGirl.create(:topic, name: "top_1")
      allow(@top_1).to receive(:parent).and_return(nil)
      allow(@top_1).to receive(:get_bros).and_return([@top_1, @top_2])
      @top_2 = FactoryGirl.create(:topic, name: "top_2")
      allow(@top_2).to receive(:parent).and_return(nil)
      allow(@top_2).to receive(:get_bros).and_return([@top_1, @top_2])

      allow(Topic).to receive(:all).and_return([@top_1, @top_2])
      result = Topic.find_top_topics
      expect(result).to eq([@top_1, @top_2])
    end
  end

  describe "get_bros" do
    it "should be able to manage top topics" do
      @top_1 = Topic.create()
      @top_2 = Topic.create()
      @top_3 = Topic.create()
      expect(@top_1.get_bros).to eq([@top_1, @top_2, @top_3])
    end
    it "should be able to manage sub topics" do
      @parent = Topic.create()
      @sub_1 = Topic.create(parent: @parent)
      @sub_2 = Topic.create(parent: @parent)
      @sub_3 = Topic.create(parent: @parent)
      expect(@sub_1.get_bros).to eq([@sub_1, @sub_2, @sub_3])
    end
  end

  describe "downward" do
    before :each do
      @tem_size = Topic.find_top_topics.size
      @top_1 = Topic.create(name: "top_1", parent: nil)
      @top_2 = Topic.create(name: "top_2", parent: nil)
      @top_3 = Topic.create(name: "top_3", parent: nil)
      @sub_1 = Topic.create(name: "sub_1", parent: @top_1)
      @sub_2 = Topic.create(name: "sub_2", parent: @top_1)
      @sub_3 = Topic.create(name: "sub_3", parent: @top_1)
    end
    it "should be able to arrange topics" do
      @top_2.downward
      expect(Topic.find(@top_1.id).order).to eq(@tem_size + 1)
      expect(Topic.find(@top_2.id).order).to eq(@tem_size + 3)
      expect(Topic.find(@top_3.id).order).to eq(@tem_size + 2)
    end
    it "should be able to arrange sub topics" do
      @sub_2.downward
      expect(Topic.find(@sub_1.id).order).to eq(1)
      expect(Topic.find(@sub_2.id).order).to eq(3)
      expect(Topic.find(@sub_3.id).order).to eq(2)
    end
    it "should leave the topic unchanged if it is at bottom" do
      @sub_3.downward
      expect(Topic.find(@sub_3.id).order).to eq(3)
    end
  end

  describe "upward" do
    before :each do
      @tem_size = Topic.find_top_topics.size
      @top_1 = Topic.create(name: "top_1", parent: nil)
      @top_2 = Topic.create(name: "top_2", parent: nil)
      @top_3 = Topic.create(name: "top_3", parent: nil)
      @sub_1 = Topic.create(name: "sub_1", parent: @top_1)
      @sub_2 = Topic.create(name: "sub_2", parent: @top_1)
      @sub_3 = Topic.create(name: "sub_3", parent: @top_1)
    end
    it "should be able to arrange topics" do
      @top_2.upward
      expect(Topic.find(@top_1.id).order).to eq(@tem_size + 2)
      expect(Topic.find(@top_2.id).order).to eq(@tem_size + 1)
      expect(Topic.find(@top_3.id).order).to eq(@tem_size + 3)
    end
    it "should be able to arrange sub topics" do
      @sub_2.upward
      expect(Topic.find(@sub_1.id).order).to eq(2)
      expect(Topic.find(@sub_2.id).order).to eq(1)
      expect(Topic.find(@sub_3.id).order).to eq(3)
    end
    it "should leave the topic unchanged if it is at top" do
      @sub_1.upward
      expect(Topic.find(@sub_1.id).order).to eq(1)
    end
  end
end
