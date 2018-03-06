class Search < ActiveRecord::Base
    
    after_create :do_scrap
    
    has_many :scraps
    
    private
        def do_scrap
            @scrap = Scrap.new(start: self.start, finish: self.finish, external_id: self.external_id, search_id: self.id)
            @scrap.initial_finish = @scrap.finish
            @scrap.last_start = @scrap.start
            @scrap.do_scrap if @scrap.save
        end
end
