require "test_helper"

class UserDashbordControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_dashbord_index_url
    assert_response :success
  end
end
