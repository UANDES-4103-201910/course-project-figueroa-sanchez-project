require "application_system_test_case"

class AdminLocationsTest < ApplicationSystemTestCase
  setup do
    @admin_location = admin_locations(:one)
  end

  test "visiting the index" do
    visit admin_locations_url
    assert_selector "h1", text: "Admin Locations"
  end

  test "creating a Admin location" do
    visit admin_locations_url
    click_on "New Admin Location"

    fill_in "Location", with: @admin_location.location
    fill_in "User", with: @admin_location.user
    click_on "Create Admin location"

    assert_text "Admin location was successfully created"
    click_on "Back"
  end

  test "updating a Admin location" do
    visit admin_locations_url
    click_on "Edit", match: :first

    fill_in "Location", with: @admin_location.location
    fill_in "User", with: @admin_location.user
    click_on "Update Admin location"

    assert_text "Admin location was successfully updated"
    click_on "Back"
  end

  test "destroying a Admin location" do
    visit admin_locations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Admin location was successfully destroyed"
  end
end
