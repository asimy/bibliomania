class SearchPage
  attr_accessor :results, :start_index, :total_count, :search_message

  def initialize(search_message, results = [], start_index = 0, total_count = 0)
    results = results
    start_index = start_index
    total_count = total_count
    search_message = search_message
  end

end