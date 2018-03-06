require 'net/http'
class Scrap < ActiveRecord::Base
    belongs_to :search
    
    # Recursive method used to query external uri for invoices
    # Heuristic used for query is: If more than xxx results, do datediff and query again for half the time
    # Returns the number of results of invoices
    def do_scrap
        total_invoices = 0
        self.result = self.external_call
        if self.result.index("Hay") and self.result.index("Hay") > 0
            new_start = self.start
            new_finish = self.finish
            date_diff = ((new_finish - new_start).to_i / 2).to_i
            new_finish = new_start + date_diff
            ns = Scrap.create(start: new_start, finish: new_finish, external_id: self.external_id, initial_finish: self.initial_finish, last_start: self.start, search_id: self.search_id)
            total_invoices += ns.do_scrap

        else
            total_invoices += self.result.to_i
            new_start = self.finish + 1
            new_finish = self.initial_finish
            unless (new_start >= new_finish)
                ns = Scrap.create(start: new_start, finish: new_finish, external_id: self.external_id, initial_finish: self.initial_finish, last_start: self.start, search_id: self.search_id)
                total_invoices += ns.do_scrap    
            end
        end
        self.total = total_invoices
        self.save
        total_invoices
        
    end
    
    
    # Returns result of a single external api call from the response
    # If there is an HTTP error, returns "Error"
    def external_call
        params = {"id" => self.external_id, "start" => self.start, "finish" => self.finish}
        uri = URI('http://34.209.24.195/facturas')
        uri.query = URI.encode_www_form(params)
        res = Net::HTTP.get_response(uri)
        
        if res.is_a?(Net::HTTPSuccess)
            res.body
        else
            "Error"
        end
    end
    
    # Other Heuristics to test:
    # Estimate the number of resuslts per day and estimating what will the best start - end date combo will be with
    # from = self.result.index("de") + 3
    # to = self.result.index("resultados") - 1
    # num_results = self.result[from, (to - from)]
    # puts "Number of more resultos: #{num_results}"
    
end
