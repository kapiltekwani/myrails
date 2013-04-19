class SearchController < ApplicationController
  def index
    if request.post?
      @customers = Customer.search(params)
    end
  end
end
