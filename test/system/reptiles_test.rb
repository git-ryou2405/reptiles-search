require "application_system_test_case"

class ReptilesTest < ApplicationSystemTestCase
  setup do
    @reptile = reptiles(:one)
  end

  test "visiting the index" do
    visit reptiles_url
    assert_selector "h1", text: "Reptiles"
  end

  test "creating a Reptile" do
    visit reptiles_url
    click_on "New Reptile"

    fill_in "Aname", with: @reptile.aname
    fill_in "Area", with: @reptile.area
    fill_in "Arrival day", with: @reptile.arrival_day
    fill_in "Description", with: @reptile.description
    fill_in "Max", with: @reptile.max
    fill_in "Price", with: @reptile.price
    fill_in "Sales status", with: @reptile.sales_status
    fill_in "Sex", with: @reptile.sex
    fill_in "Size", with: @reptile.size
    fill_in "Tyep1", with: @reptile.tyep1
    fill_in "Tyep2", with: @reptile.tyep2
    fill_in "User", with: @reptile.user_id
    click_on "Create Reptile"

    assert_text "Reptile was successfully created"
    click_on "Back"
  end

  test "updating a Reptile" do
    visit reptiles_url
    click_on "Edit", match: :first

    fill_in "Aname", with: @reptile.aname
    fill_in "Area", with: @reptile.area
    fill_in "Arrival day", with: @reptile.arrival_day
    fill_in "Description", with: @reptile.description
    fill_in "Max", with: @reptile.max
    fill_in "Price", with: @reptile.price
    fill_in "Sales status", with: @reptile.sales_status
    fill_in "Sex", with: @reptile.sex
    fill_in "Size", with: @reptile.size
    fill_in "Tyep1", with: @reptile.tyep1
    fill_in "Tyep2", with: @reptile.tyep2
    fill_in "User", with: @reptile.user_id
    click_on "Update Reptile"

    assert_text "Reptile was successfully updated"
    click_on "Back"
  end

  test "destroying a Reptile" do
    visit reptiles_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Reptile was successfully destroyed"
  end
end
