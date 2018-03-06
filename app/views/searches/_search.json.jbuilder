json.extract! search, :id, :external_id, :start, :finish, :result, :created_at, :updated_at
json.url search_url(search, format: :json)
