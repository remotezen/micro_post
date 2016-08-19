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

end
