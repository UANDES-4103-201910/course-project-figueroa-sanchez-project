require "application_system_test_case"

class ProfileLocationsTest < ApplicationSystemTestCase
  setup do
    @profile_location = profile_locations(:one)
  end

  test "visiting the index" do
    visit profile_locations_url
    assert_selector "h1", text: "Profile Locations"
  end

  test "creating a Profile location" do
    visit profile_locations_url
    click_on "New Profile Location"

    fill_in "Location", with: @profile_location.location
    fill_in "Profile", with: @profile_location.profile
    click_on "Create Profile location"

    assert_text "Profile location was successfully created"
    click_on "Back"
  end

  test "updating a Profile location" do
    visit profile_locations_url
    click_on "Edit", match: :first

    fill_in "Location", with: @profile_location.location
    fill_in "Profile", with: @profile_location.profile
    click_on "Update Profile location"

    assert_text "Profile location was successfully updated"
    click_on "Back"
  end

  test "destroying a Profile location" do
    visit profile_locations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Profile location was successfully destroyed"
  end
end
