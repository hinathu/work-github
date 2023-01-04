require "test_helper"

class Admin::OrderControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get admin_order_show_url
    assert_response :success
  end
end
