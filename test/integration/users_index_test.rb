require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    #this is an admin user
    @user = users(:fred)
    #non-admin user
    @other = users(:one)
  end
  test "index including pagination" do
    log_in_as(@user)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    assert_select 'a[href="/users?page=1"]', count:2

    User.paginate(page: 1).each do |u|
      assert_select 'a[href=?]', user_path(u), text: u.username
    end
  end
  test "index as admin including pagination and delete links" do
    log_in_as(@user)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    first_page_of_users = User.paginate(page: 1)
    first_page_of_users.each do |u|
      assert_select 'a[href=?]', user_path(u), text:u.username
      unless u == @user
        assert_select 'a[href=?]', user_path(u), text: 'delete'
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@other)
    end
  end
  test "index as non-admin" do
    log_in_as(@other)
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end
  # test "the truth" do
  #   assert true
  # end
end
