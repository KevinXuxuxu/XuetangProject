require 'rails_helper'

RSpec.describe "courses/show", :type => :view do
  before(:each) do
    @course = assign(:course, Course.create!(
      :name => "Name",
      :description => "MyText",
      :location => "Location",
      :ctime => 1,
      :belong => "Belong",
      :teacher => "Teacher"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Location/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Belong/)
    expect(rendered).to match(/Teacher/)
  end
end
