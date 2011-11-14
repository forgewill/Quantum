require 'spec_helper'

describe "q_resources/new.html.erb" do
  before(:each) do
    assign(:q_resource, stub_model(QResource,
      :title => "MyString",
      :description => "MyString",
      :body => "MyString",
      :position => 1,
      :url => "MyString",
      :note => "MyString"
    ).as_new_record)
  end

  it "renders new q_resource form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => q_resources_path, :method => "post" do
      assert_select "input#q_resource_title", :name => "q_resource[title]"
      assert_select "input#q_resource_description", :name => "q_resource[description]"
      assert_select "input#q_resource_body", :name => "q_resource[body]"
      assert_select "input#q_resource_position", :name => "q_resource[position]"
      assert_select "input#q_resource_url", :name => "q_resource[url]"
      assert_select "input#q_resource_note", :name => "q_resource[note]"
    end
  end
end
