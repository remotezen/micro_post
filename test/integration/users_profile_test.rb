require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:fred)

  end
  test "profile display" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'h1', text: @user.name
    assert_select 'h1>img.gravatar'
    assert_select 'ol.microposts'
    assert_match @user.microposts.count.to_s, response.body
    @user.microposts.paginate(page: 1).each do |m|
      assert_match m.content, response.body
    end
  end

end
