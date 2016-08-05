require 'test_helper'
class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title, "Micropost Application"
    assert_equal full_title("Help"), "Help | Micropost Application"
  end
end
