class ScrapWorker
  include Sidekiq::Worker

  # This Worker gets a Search and starts doing the scrap on it
  def perform(search_id)
    search = Search.find(search_id)
    search.do_scrap
  end
end
