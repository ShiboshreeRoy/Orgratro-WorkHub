require "application_system_test_case"

class LearnAndEarnsTest < ApplicationSystemTestCase
  setup do
    @learn_and_earn = learn_and_earns(:one)
  end

  test "visiting the index" do
    visit learn_and_earns_url
    assert_selector "h1", text: "Learn and earns"
  end

  test "should create learn and earn" do
    visit learn_and_earns_url
    click_on "New learn and earn"

    fill_in "Link", with: @learn_and_earn.link
    fill_in "Proof", with: @learn_and_earn.proof
    fill_in "Social post", with: @learn_and_earn.social_post
    fill_in "Status", with: @learn_and_earn.status
    fill_in "User", with: @learn_and_earn.user_id
    click_on "Create Learn and earn"

    assert_text "Learn and earn was successfully created"
    click_on "Back"
  end

  test "should update Learn and earn" do
    visit learn_and_earn_url(@learn_and_earn)
    click_on "Edit this learn and earn", match: :first

    fill_in "Link", with: @learn_and_earn.link
    fill_in "Proof", with: @learn_and_earn.proof
    fill_in "Social post", with: @learn_and_earn.social_post
    fill_in "Status", with: @learn_and_earn.status
    fill_in "User", with: @learn_and_earn.user_id
    click_on "Update Learn and earn"

    assert_text "Learn and earn was successfully updated"
    click_on "Back"
  end

  test "should destroy Learn and earn" do
    visit learn_and_earn_url(@learn_and_earn)
    accept_confirm { click_on "Destroy this learn and earn", match: :first }

    assert_text "Learn and earn was successfully destroyed"
  end
end
