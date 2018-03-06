require 'rails_helper'

RSpec.describe "searches/index", type: :view do
  before(:each) do
    assign(:searches, [
      Search.create!(
        :external_id => "External",
        :result => "Result"
      ),
      Search.create!(
        :external_id => "External",
        :result => "Result"
      )
    ])
  end

  it "renders a list of searches" do
    render
    assert_select "tr>td", :text => "External".to_s, :count => 2
    assert_select "tr>td", :text => "Result".to_s, :count => 2
  end
end
