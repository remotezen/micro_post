require 'test_helper'

class MicropostsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @micropost = microposts(:one)
  end
  test "should redirect create when not logged in" do
    assert_no_difference 'Micropost.count' do
      post microposts_path, params:{
        microposts: {content: 'Ipsum locquator'}
      }
    end
    assert_redirected_to login_url
  end
end
