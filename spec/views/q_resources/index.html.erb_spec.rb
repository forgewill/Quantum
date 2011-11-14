require 'spec_helper'

describe "q_resources/index.html.erb" do
  before(:each) do
    assign(:q_resources, [
      stub_model(QResource,
        :title => "Title",
        :description => "Description",
        :body => "Body",
        :position => 1,
        :url => "Url",
        :note => "Note"
      ),
      stub_model(QResource,
        :title => "Title",
        :description => "Description",
        :body => "Body",
        :position => 1,
        :url => "Url",
        :note => "Note"
      )
    ])
  end

  it "renders a list of q_resources" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Body".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Url".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Note".to_s, :count => 2
  end
end
