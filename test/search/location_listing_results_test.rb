require "test_helper"

class LocationListingResultsTest < Minitest::Test
  def test_find_zero_results_by_zipcode
    display = SearchResultsDisplay.new
    search = Search.new(display)

    search.by_zipcode(60610)

    assert_equal("Sorry! We couldn't find anything for you :(", display.results_text)
  end

  class SearchResultsDisplay
    def results_text
      "Sorry! We couldn't find anything for you :("
    end
  end

  class Search
    def initialize(display)
    end

    def by_zipcode(zipcode)
    end
  end
end
