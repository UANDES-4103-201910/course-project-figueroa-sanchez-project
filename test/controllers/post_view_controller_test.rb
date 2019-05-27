require 'test_helper'

class PostViewControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get post_view_index_url
    assert_response :success
  end

  test "should get post" do
    get post_view_post_url
    assert_response :success
  end

end
