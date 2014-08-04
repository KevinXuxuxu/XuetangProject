require 'rails_helper'

RSpec.describe Post, :type => :model , :pending => true do
  describe "delete_comments" do
    before :each do
      @post = Post.create()
      @comment = Comment.create(post: @post)
    end
    it "should have post-comment relation" do
      expect(@post.comments).to eq([@comment])
      expect(@comment.post).to eq(@post)
    end
    it "should delete the comment when post is deleted" do
      expect(@comment).to receive(:delete)
      @post.delete
    end
  end
end
