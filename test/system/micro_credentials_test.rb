require "application_system_test_case"

class MicroCredentialsTest < ApplicationSystemTestCase
  setup do
    @micro_credential = micro_credentials(:one)
  end

  test "visiting the index" do
    visit micro_credentials_url
    assert_selector "h1", text: "Micro Credentials"
  end

  test "creating a Micro credential" do
    visit micro_credentials_url
    click_on "New Micro Credential"

    click_on "Create Micro credential"

    assert_text "Micro credential was successfully created"
    click_on "Back"
  end

  test "updating a Micro credential" do
    visit micro_credentials_url
    click_on "Edit", match: :first

    click_on "Update Micro credential"

    assert_text "Micro credential was successfully updated"
    click_on "Back"
  end

  test "destroying a Micro credential" do
    visit micro_credentials_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Micro credential was successfully destroyed"
  end
end
