require 'rails_helper'

RSpec.describe "searches/new", type: :view do
  before(:each) do
    assign(:search, Search.new(
      :external_id => "MyString",
      :result => "MyString"
    ))
  end

  it "renders new search form" do
    render

    assert_select "form[action=?][method=?]", searches_path, "post" do

      assert_select "input#search_external_id[name=?]", "search[external_id]"

      assert_select "input#search_result[name=?]", "search[result]"
    end
  end
end
