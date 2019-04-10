require 'test_helper'

class ProfileLocationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @profile_location = profile_locations(:one)
  end

  test "should get index" do
    get profile_locations_url
    assert_response :success
  end

  test "should get new" do
    get new_profile_location_url
    assert_response :success
  end

  test "should create profile_location" do
    assert_difference('ProfileLocation.count') do
      post profile_locations_url, params: { profile_location: { location: @profile_location.location, profile: @profile_location.profile } }
    end

    assert_redirected_to profile_location_url(ProfileLocation.last)
  end

  test "should show profile_location" do
    get profile_location_url(@profile_location)
    assert_response :success
  end

  test "should get edit" do
    get edit_profile_location_url(@profile_location)
    assert_response :success
  end

  test "should update profile_location" do
    patch profile_location_url(@profile_location), params: { profile_location: { location: @profile_location.location, profile: @profile_location.profile } }
    assert_redirected_to profile_location_url(@profile_location)
  end

  test "should destroy profile_location" do
    assert_difference('ProfileLocation.count', -1) do
      delete profile_location_url(@profile_location)
    end

    assert_redirected_to profile_locations_url
  end
end
