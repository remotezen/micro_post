require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase
  def setup
    @user = users(:fred)
    @relationship = @user.active_relationships.build(followed_id: users(:one).id)
  end

  test "should be valid" do
    assert @relationship.valid?
  end

  test "should require a follower_id" do
    @relationship.follower_id = nil
    assert_not @relationship.valid?
  end

  test "should require a followed_id" do
    @relationship.followed_id = nil
    assert_not @relationship.valid?
  end

  test "should follow and unfollow a user" do
    fred = users(:fred)
    one = users(:one)
    assert_not fred.following?(one)
    fred.follow(one)
    assert fred.following?(one)
    one.follow(fred)
    assert fred.follower?(one)
    one.unfollow(fred)
    assert_not one.following?(fred)
    assert_not fred.follower?(one)
  end

  # test "the truth" do
  #   assert true
  # end
end
