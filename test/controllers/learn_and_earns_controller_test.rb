require "test_helper"

class LearnAndEarnsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @learn_and_earn = learn_and_earns(:one)
  end

  test "should get index" do
    get learn_and_earns_url
    assert_response :success
  end

  test "should get new" do
    get new_learn_and_earn_url
    assert_response :success
  end

  test "should create learn_and_earn" do
    assert_difference("LearnAndEarn.count") do
      post learn_and_earns_url, params: { learn_and_earn: { link: @learn_and_earn.link, proof: @learn_and_earn.proof, social_post: @learn_and_earn.social_post, status: @learn_and_earn.status, user_id: @learn_and_earn.user_id } }
    end

    assert_redirected_to learn_and_earn_url(LearnAndEarn.last)
  end

  test "should show learn_and_earn" do
    get learn_and_earn_url(@learn_and_earn)
    assert_response :success
  end

  test "should get edit" do
    get edit_learn_and_earn_url(@learn_and_earn)
    assert_response :success
  end

  test "should update learn_and_earn" do
    patch learn_and_earn_url(@learn_and_earn), params: { learn_and_earn: { link: @learn_and_earn.link, proof: @learn_and_earn.proof, social_post: @learn_and_earn.social_post, status: @learn_and_earn.status, user_id: @learn_and_earn.user_id } }
    assert_redirected_to learn_and_earn_url(@learn_and_earn)
  end

  test "should destroy learn_and_earn" do
    assert_difference("LearnAndEarn.count", -1) do
      delete learn_and_earn_url(@learn_and_earn)
    end

    assert_redirected_to learn_and_earns_url
  end
end
