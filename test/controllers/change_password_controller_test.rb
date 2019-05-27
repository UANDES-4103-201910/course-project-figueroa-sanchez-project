require 'test_helper'

class ChangePasswordControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get change_password_index_url
    assert_response :success
  end

end
