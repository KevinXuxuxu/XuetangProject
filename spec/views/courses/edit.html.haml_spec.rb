require 'rails_helper'

RSpec.describe "courses/edit", :type => :view do
  before(:each) do
    @course = assign(:course, Course.create!(
      :name => "MyString",
      :description => "MyText",
      :location => "MyString",
      :ctime => 1,
      :belong => "MyString",
      :teacher => "MyString"
    ))
  end

  it "renders the edit course form" do
    render

    assert_select "form[action=?][method=?]", course_path(@course), "post" do

      assert_select "input#course_name[name=?]", "course[name]"

      assert_select "textarea#course_description[name=?]", "course[description]"

      assert_select "input#course_location[name=?]", "course[location]"

      assert_select "input#course_ctime[name=?]", "course[ctime]"

      assert_select "input#course_belong[name=?]", "course[belong]"

      assert_select "input#course_teacher[name=?]", "course[teacher]"
    end
  end
end
