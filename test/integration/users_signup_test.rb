require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params:{user:{ name:"",
                                      email: "user@invalid",
                                      username: "remotebuddy",
                                      password: "foo",
                                      password_confirmation: "bar"
                                      }}
    end
    assert_template 'users/new'
    assert_not flash[:success]
    assert flash[:error]
    assert_response 200

  end
end
