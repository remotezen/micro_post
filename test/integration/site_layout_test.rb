require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "main page links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "title", full_title("Home")
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
