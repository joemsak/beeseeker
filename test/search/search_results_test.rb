require "test_helper"
require "./test/search/searchable_list"

class SearchResultsTest < Minitest::Test
  def test_searchable_list_finds_zero_results
    SearchableList.stub(:search_by_zipcode, []) do
      assert_empty(SearchableList.query(zipcode: 60610))
    end
  end

  def test_searchableList_finds_one_result
    search_result = Minitest::Mock.new

    SearchableList.stub(:search_by_zipcode, [search_result]) do
      assert_equal([search_result], SearchableList.query(zipcode: 60610))
    end
  end
end
