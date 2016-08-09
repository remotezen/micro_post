require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
  end
  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params:{session: { login:"" , password:""}}
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
  test "login with valid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params:{session:{login: @user.username, password: @user.password}}
    assert flash[:danger]
    assert_redirected_to @user
  end
end
