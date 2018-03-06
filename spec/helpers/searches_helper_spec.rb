require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the SearchesHelper. For example:
#
# describe SearchesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe SearchesHelper, type: :helper do
  pending "add some examples to (or delete) #{__FILE__}"
end

RSpec.configure do |config|
  config.before(:all) { @latest_id = 0, @result = "Working" }
end