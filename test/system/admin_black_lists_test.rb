require "application_system_test_case"

class AdminBlackListsTest < ApplicationSystemTestCase
  setup do
    @admin_black_list = admin_black_lists(:one)
  end

  test "visiting the index" do
    visit admin_black_lists_url
    assert_selector "h1", text: "Admin Black Lists"
  end

  test "creating a Admin black list" do
    visit admin_black_lists_url
    click_on "New Admin Black List"

    fill_in "Black list", with: @admin_black_list.black_list_id
    fill_in "User", with: @admin_black_list.user_id
    click_on "Create Admin black list"

    assert_text "Admin black list was successfully created"
    click_on "Back"
  end

  test "updating a Admin black list" do
    visit admin_black_lists_url
    click_on "Edit", match: :first

    fill_in "Black list", with: @admin_black_list.black_list_id
    fill_in "User", with: @admin_black_list.user_id
    click_on "Update Admin black list"

    assert_text "Admin black list was successfully updated"
    click_on "Back"
  end

  test "destroying a Admin black list" do
    visit admin_black_lists_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Admin black list was successfully destroyed"
  end
end
