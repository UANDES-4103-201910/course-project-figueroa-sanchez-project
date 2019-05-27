require 'test_helper'

class AdminBlackListsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_black_list = admin_black_lists(:one)
  end

  test "should get index" do
    get admin_black_lists_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_black_list_url
    assert_response :success
  end

  test "should create admin_black_list" do
    assert_difference('AdminBlackList.count') do
      post admin_black_lists_url, params: { admin_black_list: { black_list_id: @admin_black_list.black_list_id, user_id: @admin_black_list.user_id } }
    end

    assert_redirected_to admin_black_list_url(AdminBlackList.last)
  end

  test "should show admin_black_list" do
    get admin_black_list_url(@admin_black_list)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_black_list_url(@admin_black_list)
    assert_response :success
  end

  test "should update admin_black_list" do
    patch admin_black_list_url(@admin_black_list), params: { admin_black_list: { black_list_id: @admin_black_list.black_list_id, user_id: @admin_black_list.user_id } }
    assert_redirected_to admin_black_list_url(@admin_black_list)
  end

  test "should destroy admin_black_list" do
    assert_difference('AdminBlackList.count', -1) do
      delete admin_black_list_url(@admin_black_list)
    end

    assert_redirected_to admin_black_lists_url
  end
end
