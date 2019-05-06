require 'test_helper'

class SearcherControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get searcher_index_url
    assert_response :success
  end

end
