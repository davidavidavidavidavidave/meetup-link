require "test_helper"

class UserMeetupsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get user_meetups_create_url
    assert_response :success
  end

  test "should get update" do
    get user_meetups_update_url
    assert_response :success
  end
end
