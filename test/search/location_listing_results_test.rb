require "test_helper"

class LocationListingResultsTest < Minitest::Test
  def test_find_zero_results_by_zipcode
    display = SearchResultsDisplay.new
    search = Search.new(display)

    search.by_zipcode(60610)

    assert_equal("Sorry! We couldn't find anything for you :(", display.results_text)
  end

  def test_find_one_result_by_zipcode
    display = SearchResultsDisplay.new
    searchable_list = Minitest::Mock.new
    search_result = SearchResult.new

    search = Search.new(display, searchable_list)

    searchable_list.expect(:query, [search_result], [{ zipcode: 60610 }])

    search.by_zipcode(60610)

    assert_equal([search_result], display.results)
  end

  class SearchResult
  end

  class SearchableList
    def self.query(options)
    end
  end

  class SearchResultsDisplay
    attr_accessor :results

    def results_text
      "Sorry! We couldn't find anything for you :("
    end
  end

  class Search
    def initialize(display, list = SearchableList)
      @display = display
      @list = list
    end

    def by_zipcode(zipcode)
      @display.results = @list.query(zipcode: zipcode)
    end
  end
end
