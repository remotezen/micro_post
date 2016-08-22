require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
    @user = users(:fred)
  end

  test "password resets" do
    get new_password_resets_path
    post password_resets_path, params:{password_reset: {email:""}}
    assert_not flash.empty?
    assert_template 'password_resets/new'
  end

end
