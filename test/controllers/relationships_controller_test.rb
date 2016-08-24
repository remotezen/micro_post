require 'test_helper'

class RelationshipsControllerTest < ActionDispatch::IntegrationTest
  test "create should require a logged in user" do
    assert_no_difference 'Relationship.count' do
      post relationships_path
    end
    assert_redirected_to login_url
  end

  test "destroy should require logged in user" do
    assert_no_difference 'Relationship.count' do
      delete relationship_path(relationships(:fred_following))
    end
  end
  # test "the truth" do
  #   assert true
  # end
end
