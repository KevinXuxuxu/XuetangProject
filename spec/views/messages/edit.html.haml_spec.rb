require 'rails_helper'

RSpec.describe "messages/edit", :type => :view do
  before(:each) do
    @message = assign(:message, Message.create!(
      :kind => "MyString",
      :url => "MyString"
    ))
  end

  it "renders the edit message form" do
    render

    assert_select "form[action=?][method=?]", message_path(@message), "post" do

      assert_select "input#message_kind[name=?]", "message[kind]"

      assert_select "input#message_url[name=?]", "message[url]"
    end
  end
end
