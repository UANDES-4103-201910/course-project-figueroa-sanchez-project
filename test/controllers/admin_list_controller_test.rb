require 'test_helper'

class AdminListControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_list_index_url
    assert_response :success
  end

end
