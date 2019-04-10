require 'test_helper'

class AdminLocationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_location = admin_locations(:one)
  end

  test "should get index" do
    get admin_locations_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_location_url
    assert_response :success
  end

  test "should create admin_location" do
    assert_difference('AdminLocation.count') do
      post admin_locations_url, params: { admin_location: { location: @admin_location.location, user: @admin_location.user } }
    end

    assert_redirected_to admin_location_url(AdminLocation.last)
  end

  test "should show admin_location" do
    get admin_location_url(@admin_location)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_location_url(@admin_location)
    assert_response :success
  end

  test "should update admin_location" do
    patch admin_location_url(@admin_location), params: { admin_location: { location: @admin_location.location, user: @admin_location.user } }
    assert_redirected_to admin_location_url(@admin_location)
  end

  test "should destroy admin_location" do
    assert_difference('AdminLocation.count', -1) do
      delete admin_location_url(@admin_location)
    end

    assert_redirected_to admin_locations_url
  end
end
