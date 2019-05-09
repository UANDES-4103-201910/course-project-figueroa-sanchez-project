require 'test_helper'

class RecoverPasswordControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get recover_password_index_url
    assert_response :success
  end

end
