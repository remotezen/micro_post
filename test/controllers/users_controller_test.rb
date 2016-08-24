require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @other = users(:one)
    @user = users(:fred)
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
  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to login_url

  end
  test "should should redirect destroy for non admin user" do
    log_in_as(@other)
    assert_no_difference 'User.count' do
      delete user_path(@other)
    end
    assert_redirected_to root_url
  end
  test "admin should be able to delete user" do
    log_in_as(@user)
    assert_difference 'User.count', -1  do
      delete user_path(@other)
    end
    assert_redirected_to users_path
  end

  test "should redirect following when not logged in" do
    get following_user_path(@user)
    assert_redirected_to login_path
  end

  test "should redirect followers when not logged in" do
    get followers_user_path(@user)
    assert_redirected_to login_url
  end


end
