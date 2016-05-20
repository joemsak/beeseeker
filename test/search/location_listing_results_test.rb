require "test_helper"
require "./test/search/searchable_list"

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
    search_result = Minitest::Mock.new

    search = Search.new(display, searchable_list)

    searchable_list.expect(:query, [search_result], [{ zipcode: 60610 }])

    search.by_zipcode(60610)

    assert_equal([search_result], display.results)
    assert_equal("We found 1 result for you!", display.results_text)
  end

  def test_find_several_results_by_zipcode
    display = SearchResultsDisplay.new
    searchable_list = Minitest::Mock.new
    search_result = Minitest::Mock.new

    search = Search.new(display, searchable_list)

    searchable_list.expect(:query, [search_result] * 3, [{ zipcode: 60610 }])

    search.by_zipcode(60610)

    assert_equal([search_result] * 3, display.results)
    assert_equal("We found 3 results for you!", display.results_text)
  end

  class SearchResultsDisplay
    attr_accessor :results

    def results_text
      if results.one?
        "We found #{results.count} result for you!"
      elsif results.any?
        "We found #{results.count} results for you!"
      else
        "Sorry! We couldn't find anything for you :("
      end
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
