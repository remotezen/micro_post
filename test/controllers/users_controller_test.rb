require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
  end

  test "should get new" do
    get signup_url
    assert_response :success
  end
  test "should get show" do
    log_in_as(@user)
    get user_path(@user)
    assert_response :success
  end
  test "should not redirect to users/index when not logged in" do
    get users_path
    assert_redirected_to login_url
  end

end
