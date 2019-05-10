require 'test_helper'

class SuperAdminHomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get super_admin_home_index_url
    assert_response :success
  end

end
