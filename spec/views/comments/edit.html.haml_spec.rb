require 'rails_helper'

RSpec.describe "comments/edit", :type => :view, :pending => true do
  before(:each) do
    @comment = assign(:comment, Comment.create!(
      :content => "MyText",
    ))
  end

  it "renders the edit comment form" do
    render

    assert_select "form[action=?][method=?]", comment_path(@comment), "post" do

      assert_select "textarea#comment_content[name=?]", "comment[content]"

    end
  end
end
