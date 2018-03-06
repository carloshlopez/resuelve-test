require 'rails_helper'

RSpec.describe "Searches", type: :request do
  describe "GET /searches" do
    it "works! (now write some real specs)" do
      get searches_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /api/v1/searchs" do
    it "Create search for id with start and finish dates" do
      #params = {"id" => "8672e846-9c89-4dbf-a1cc-b85a2da5abe1", "start" => "2017-01-01", "finish" => "2017-01-11"}
      
      params = { :search => {
          :external_id => "8672e846-9c89-4dbf-a1cc-b85a2da5abe1",
          :start => "2017-01-01",
          :finish => "2017-01-01"
          }
      } 
      
      get api_v1_search_path, params
      puts "Respose #{response.body}"
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)["search_id"]).to eq(1)
      expect(JSON.parse(response.body)["result"]).to eq("Working")
      
      get api_v1_search_result_path(search_id: 1)
      puts "Respose #{response.body}"
      expect(response.body).to eq("9")
      
    end
    
  end
  
  
end
