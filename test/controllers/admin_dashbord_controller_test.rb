require "test_helper"

class AdminDashbordControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_dashbord_index_url
    assert_response :success
  end
end
