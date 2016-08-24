require 'test_helper'

class FollowingTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:fred)
    log_in_as(@user)
  end

  test "following page" do
    get following_user_path(@user)
    assert_not @user.following.empty?
    assert_match @user.following.count.to_s, response.body
    @user.following.each do |u|
      assert_select "a[href=?]", user_path(u)
    end

  end
  # test "the truth" do
  #   assert true
  # end
end
