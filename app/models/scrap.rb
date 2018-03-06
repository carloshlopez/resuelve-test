require 'net/http'
class Scrap < ActiveRecord::Base
    belongs_to :search
    
    def do_scrap
        total_invoices = 0
        puts "Starting Scrap"
        # params = {"id" => "8672e846-9c89-4dbf-a1cc-b85a2da5abe1", "start" => "2017-01-01", "finish" => "2017-01-11"}
        params = {"id" => self.external_id, "start" => self.start, "finish" => self.finish}
        uri = URI('http://34.209.24.195/facturas')
        uri.query = URI.encode_www_form(params)
        res = Net::HTTP.get_response(uri)
        
        if res.is_a?(Net::HTTPSuccess)
            puts res.body 
            self.result = res.body.encode("UTF-8", "Windows-1252")
            
        else
            puts "error #{res.body}"
            self.result = "Error"
        end
        
        self.save
        
        
        puts "Este es el self.result: #{self.result} - #{self.result.index("Hay")} #{self.result.instance_of?(String)}" 
        
        if self.result.index("Hay") and self.result.index("Hay") > 0
            from = self.result.index("de") + 3
            to = self.result.index("resultados") - 1
            num_results = self.result[from, (to - from)]
            puts "Number of more resultos: #{num_results}"
            new_start = self.start
            new_finish = self.finish
            puts "Old date_diff #{(new_finish - new_start).to_i}"
            date_diff = ((new_finish - new_start).to_i / 2).to_i
            puts "New Date diff #{date_diff}"
            new_start = new_start
            new_finish = new_start + date_diff
            puts "New date start #{new_start}"
            puts "New date finish #{new_finish}"
            ns = Scrap.create(start: new_start, finish: new_finish, external_id: self.external_id, initial_finish: self.initial_finish, last_start: self.start, search_id: self.search_id)
            total_invoices += ns.do_scrap

        else
            total_invoices += self.result.to_i
            new_start = self.finish
            new_finish = self.initial_finish
            puts "New date start #{new_start}"
            puts "New date finish #{new_finish}"
            unless (new_start == new_finish || (new_finish == self.initial_finish && new_start == self.last_start))
                ns = Scrap.create(start: new_start, finish: new_finish, external_id: self.external_id, initial_finish: self.initial_finish, last_start: self.start, search_id: self.search_id)
                total_invoices += ns.do_scrap    
            end
            
        end
        puts "total_invoices: #{total_invoices}"
        self.total = total_invoices
        self.save
        self.search.result = total_invoices
        self.search.save
        total_invoices
        
    end
    
end
