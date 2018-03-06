module Api
  module V1
    class SearchesController < InheritedResources::Base
      respond_to :json
      rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
      rescue_from Exception, :with => :handle_exception
      
      def do_search
        puts "All params #{params.inspect}"
        @search = Search.new(search_params)
        if(@search.save)
          puts "New seach #{@search.inspect}"
          render :json => {search_id: @search.id, result: @search.result}, :status => :created
        else
          render :json => {:error => @search.errors}, :status => :bad_request
        end
      end
      
      def get_result
        puts "All params #{params.inspect}  - search id: #{params[:search_id]}"
        puts "All searchs: #{Search.all.inspect}"
        @search = Search.find(params[:search_id])
        respond_with @search.result
      end
      
      private
        def handle_exception(error)
          render :json => {:error => error.inspect}, :status => :bad_request
        end
      
        def search_params
          params.require(:search).permit(:start, :finish, :external_id)
        end
      
    end
  end
end