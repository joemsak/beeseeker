require "test_helper"
require "./test/search/searchable_list"

class SearchResultsTest < Minitest::Test
  def test_searchable_list_finds_zero_results
    assert_empty(SearchableList.query(some_attribute: 'nothing'))
  end
end
