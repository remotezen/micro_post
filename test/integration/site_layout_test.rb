require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:fred)
  end
  test "main page links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "title", full_title("Home")
    assert_select "a[href=?]", login_path
    log_in_as(@user)
    get root_path
    assert_select "a[href=?]", login_path, count:0
    assert_select "a[href=?]", edit_user_path(@user)
    assert_select "a[href=?]", logout_path, method: :delete
    delete logout_path
    get root_path
    assert_select "a[href=?]", logout_path, method: :delete, count:0
    assert_select "a[href=?]", edit_user_path(@user),count:0
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", users_path, count: 0
    get contact_path
    assert_select "title", full_title("Contact")
    get about_path
    assert_select "title", full_title("About")
    log_in_as(@user)
    get users_path
    assert_select "title", full_title("All users")
    assert_select "ul.users li"



  end
  test "static  pages contact" do
    get contact_path
    assert_select "title", full_title("Contact")
  end
  test "static pages about" do
    get about_path
    assert_select "title", full_title("About")
  end
  test "static pages help" do
    get help_path
    assert_select "title", full_title("Help")
  end
  test "users signup page" do
    get signup_path
    assert_select "title", full_title("Sign up")
  end
end
