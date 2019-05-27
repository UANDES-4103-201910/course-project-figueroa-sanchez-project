require 'test_helper'

class SharedPostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @shared_post = shared_posts(:one)
  end

  test "should get index" do
    get shared_posts_url
    assert_response :success
  end

  test "should get new" do
    get new_shared_post_url
    assert_response :success
  end

  test "should create shared_post" do
    assert_difference('SharedPost.count') do
      post shared_posts_url, params: { shared_post: { post: @shared_post.post, user: @shared_post.user } }
    end

    assert_redirected_to shared_post_url(SharedPost.last)
  end

  test "should show shared_post" do
    get shared_post_url(@shared_post)
    assert_response :success
  end

  test "should get edit" do
    get edit_shared_post_url(@shared_post)
    assert_response :success
  end

  test "should update shared_post" do
    patch shared_post_url(@shared_post), params: { shared_post: { post: @shared_post.post, user: @shared_post.user } }
    assert_redirected_to shared_post_url(@shared_post)
  end

  test "should destroy shared_post" do
    assert_difference('SharedPost.count', -1) do
      delete shared_post_url(@shared_post)
    end

    assert_redirected_to shared_posts_url
  end
end
