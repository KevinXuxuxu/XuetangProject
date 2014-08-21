require 'rails_helper'

RSpec.describe "messages/index", :type => :view do
  before(:each) do
    assign(:messages, [
      Message.create!(
        :kind => "Kind",
        :url => "Url"
      ),
      Message.create!(
        :kind => "Kind",
        :url => "Url"
      )
    ])
  end

  it "renders a list of messages" do
    render
    assert_select "tr>td", :text => "Kind".to_s, :count => 2
    assert_select "tr>td", :text => "Url".to_s, :count => 2
  end
end
