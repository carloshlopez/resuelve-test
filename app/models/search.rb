class Search < ActiveRecord::Base
    validates :start, presence: true
    validates :finish, presence: true
    validates :external_id, presence: true
    after_commit :async_scrap
    has_many :scraps
    
    # Starts a number of scraps depending on its attributes: external_id:string, start:date, finish:date 
    def do_scrap
        t1 = Time.now
        @scrap = Scrap.new(start: self.start, finish: self.finish, external_id: self.external_id, search_id: self.id)
        @scrap.initial_finish = @scrap.finish
        @scrap.last_start = @scrap.start
        self.result = @scrap.do_scrap if @scrap.save
        t2 = Time.now
        self.time_spent = (t2 - t1).in_milliseconds
        self.save
    end
    
    private
        # Queue a Scrap Worker as soon as a search is created
        def async_scrap
            ScrapWorker.perform_async(self.id)
        end
end
