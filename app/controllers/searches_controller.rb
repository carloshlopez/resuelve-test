class SearchesController < InheritedResources::Base

  private

    def search_params
      params.require(:search).permit(:external_id, :start, :finish, :result)
    end
end

