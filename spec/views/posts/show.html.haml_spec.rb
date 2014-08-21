require 'rails_helper'

RSpec.describe "posts/show", :type => :view do
  before(:each) do
    @post = assign(:post, Post.create!(:title => "Title",:content => "MyText"))
    @comment = assign(:comment, Comment.create!(:content => "Comment Content", :post => @post))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
  end

  it 'display a list of comments' do
    render
    expect(rendered).to match(/Comment Content/)
  end
end
