require 'rails_helper'

RSpec.describe Post, :type => :model do
  describe 'post-comment relationship' do
    it "should have post-comment relation" do
      @post = Post.create()
      @comment = Comment.create(post: @post)
      expect(@post.comments).to eq([@comment])
      expect(@comment.post).to eq(@post)
    end
  end

  describe "delete_comments" do
    before :each do
      @post = Post.create()
      @comment = Comment.create(post: @post)
    end
    it 'should call delete_comments' do
      expect(@post).to receive(:delete_comments)
      @post.destroy
    end
    it "should delete the comments when post is deleted" do
      expect_any_instance_of(Comment).to receive(:destroy)
      @post.destroy
    end
  end
end
