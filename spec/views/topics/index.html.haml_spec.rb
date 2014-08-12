require 'rails_helper'

RSpec.describe "topics/index", :type => :view do
  before(:each) do
    assign(:topics, [
      Topic.create!(
                    :name => "Name",
                    :description => "Description",
                    :order => 1
      ),
      Topic.create!(
                    :name => "Name",
                    :description => "Description",
                    :order => 1
      )
    ])
  end

  it "renders a list of topics" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "1".to_s, :count => 1
    assert_select "tr>td", :text => "2".to_s, :count => 1

  end
end