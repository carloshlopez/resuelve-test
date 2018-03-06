require 'rails_helper'

RSpec.describe "searches/edit", type: :view do
  before(:each) do
    @search = assign(:search, Search.create!(
      :external_id => "MyString",
      :result => "MyString"
    ))
  end

  it "renders the edit search form" do
    render

    assert_select "form[action=?][method=?]", search_path(@search), "post" do

      assert_select "input#search_external_id[name=?]", "search[external_id]"

      assert_select "input#search_result[name=?]", "search[result]"
    end
  end
end
