require "application_system_test_case"

class ProfilePhotosTest < ApplicationSystemTestCase
  setup do
    @profile_photo = profile_photos(:one)
  end

  test "visiting the index" do
    visit profile_photos_url
    assert_selector "h1", text: "Profile Photos"
  end

  test "creating a Profile photo" do
    visit profile_photos_url
    click_on "New Profile Photo"

    fill_in "Photo link", with: @profile_photo.photo_link
    fill_in "Profile", with: @profile_photo.profile
    click_on "Create Profile photo"

    assert_text "Profile photo was successfully created"
    click_on "Back"
  end

  test "updating a Profile photo" do
    visit profile_photos_url
    click_on "Edit", match: :first

    fill_in "Photo link", with: @profile_photo.photo_link
    fill_in "Profile", with: @profile_photo.profile
    click_on "Update Profile photo"

    assert_text "Profile photo was successfully updated"
    click_on "Back"
  end

  test "destroying a Profile photo" do
    visit profile_photos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Profile photo was successfully destroyed"
  end
end
