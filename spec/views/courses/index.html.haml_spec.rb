require 'rails_helper'

RSpec.describe "courses/index", :type => :view do
  before(:each) do
    assign(:courses, [
      Course.create!(
        :name => "Name",
        :description => "MyText",
        :location => "Location",
        :ctime => 1,
        :belong => "Belong",
        :teacher => "Teacher"
      ),
      Course.create!(
        :name => "Name",
        :description => "MyText",
        :location => "Location",
        :ctime => 1,
        :belong => "Belong",
        :teacher => "Teacher"
      )
    ])
  end

  it "renders a list of courses" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Location".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Belong".to_s, :count => 2
    assert_select "tr>td", :text => "Teacher".to_s, :count => 2
  end
end
