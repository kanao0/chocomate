require "test_helper"

class Admin::OriginsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_origins_index_url
    assert_response :success
  end

  test "should get edit" do
    get admin_origins_edit_url
    assert_response :success
  end
end
