require "test_helper"

class LocationListingResultsTest < Minitest::Test
  def test_find_zero_results
    display = Display.new
    assert_equal("Sorry! We couldn't find anything for you :(", display.results_text)
  end

  class Display
    def results_text
      "Sorry! We couldn't find anything for you :("
    end
  end
end
