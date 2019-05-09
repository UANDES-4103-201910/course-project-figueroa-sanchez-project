require 'test_helper'

class ProfileViewControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get profile_view_index_url
    assert_response :success
  end

end
