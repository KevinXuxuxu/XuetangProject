require 'rails_helper'

RSpec.describe "users/index", :type => :view do
  before(:each) do
    assign(:users, [
      User.create!(
        :name => "Name",
        :stu_id => "Stu"
      ),
      User.create!(
        :name => "Name",
        :stu_id => "Stu"
      )
    ])
  end

  it "renders a list of users" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Stu".to_s, :count => 2
  end
end
