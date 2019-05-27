require 'test_helper'

class ReportPostControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get report_post_index_url
    assert_response :success
  end

end
