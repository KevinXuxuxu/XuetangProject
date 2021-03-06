require 'rails_helper'

RSpec.describe "comments/new", :type => :view, :pending => true do
  before(:each) do
    assign(:comment, Comment.new(
      :content => "MyText",
    ))
  end

  it "renders new comment form" do
    render

    assert_select "form[action=?][method=?]", comments_path, "post" do

      assert_select "textarea#comment_content[name=?]", "comment[content]"
    end
  end
end
