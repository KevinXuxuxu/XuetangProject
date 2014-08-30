require 'rails_helper'

RSpec.describe User, :type => :model do
  describe 'articles relation' do
    before :each do
      @user = User.create
      @article_1 = Article.create(author: @user)
      @article_2 = Article.create(author: @user)
    end
    it 'should be able to find all articles' do
      expect(@user.articles).to eq([@article_1, @article_2])
    end
  end

  describe 'posts relation' do
    before :each do
      @user = User.create
      @post_1 = Post.create(author: @user)
      @post_2 = Post.create(author: @user)
    end
    it 'should be able to find all posts' do
      expect(@user.posts).to eq([@post_1, @post_2])
    end
  end

  describe 'comments relation' do
    before :each do
      @user = User.create
      @comment_1 = Comment.create(author: @user)
      @comment_2 = Comment.create(author: @user)
    end
    it 'should be able to find all comments' do
      expect(@user.comments).to eq([@comment_1, @comment_2])
    end
  end

  describe 'privilege relation' do
    before :each do
      @user = User.create
      @priv_1 = CategoryPrivilege.create(user: @user)
      @priv_2 = TopicPrivilege.create(user: @user)
    end
    it 'should be able to find privileges' do
      expect(@user.category_privileges).to eq([@priv_1])
      expect(@user.topic_privileges).to eq([@priv_2])
    end
  end

  describe 'process_privileges' do
    before :each do
      @user = User.create()
      @priv_1 = FactoryGirl.create(:category_privilege)
      @priv_2 = FactoryGirl.create(:topic_privilege)
      allow(@user).to receive(:category_privileges).and_return([@priv_1])
      allow(@user).to receive(:topic_privileges).and_return([@priv_2])
      allow(@priv_1).to receive(:destroy)
      allow(@priv_2).to receive(:destroy)
    end
    it 'should be called when a user is destroyed' do
      expect(@user).to receive(:process_privileges)
      @user.destroy
    end

    it 'should delete all relevant privileges' do
      expect(@priv_1).to receive(:destroy)
      expect(@priv_2).to receive(:destroy)
      @user.destroy
    end
  end

end
