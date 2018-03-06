module Api
  module V1
    class SearchesController < InheritedResources::Base
      respond_to :json
      rescue_from ActiveRecord::RecordNotFound, :with => :handle_exception
      rescue_from Exception, :with => :handle_exception
      
      # API Endpoint api/v1/search
      # Params: in json 
      # "search" : {
      # "external_id" : "8672e846-9c89-4dbf-a1cc-b85a2da5abe1",
      # "start": "2017-01-01",
      # "finish": "2017-01-01" }
      # Starts job to do a scrap for results with external call
      # Returns search_id to to look_up later
      def do_search
        @search = Search.new(search_params)
        if(@search.save)
          render json: {search_id: @search.id}, :status => :created
        else
          render json: {:error => @search.errors}, :status => :bad_request
        end
      end
      
      # API Endpoint api/v1/search_result/:search_id
      # Returns: {"result": "xx", "num_external_calls" : yy}
      # result could be "Working" if job has not finished, or a number in a string, ex: "2"
      # num_external_calls is an integer
      def get_result
        @search = Search.find(params[:search_id])
        render json: {result: @search.result, num_external_calls: @search.scraps.count, id: @search.external_id, start: @search.start, finish: @search.finish}
      end
      
      private
        def handle_exception(error)
          render json: {:error => error.inspect}, :status => :bad_request
        end
      
        def search_params
          params.require(:search).permit(:start, :finish, :external_id)
        end
      
    end
  end
end