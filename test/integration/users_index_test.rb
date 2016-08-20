require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:fred)
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
  # test "the truth" do
  #   assert true
  # end
end
