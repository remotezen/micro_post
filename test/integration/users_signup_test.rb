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
    assert_select 'div#error_explanation'
    assert_select 'div.alert.alert-danger', text: "The form contains 5 errors"
    assert_select 'div#error_explanation ul li', text: "Name can't be blank"
    assert_select 'div#error_explanation  ul li', text: "Email is invalid"
    assert_select 'div#error_explanation  ul li', text: "Username can't be blank"
    assert_select 'div#error_explanation  ul li', text: "Password confirmation doesn't match Password"
    assert_not flash[:success]
    assert flash[:error]
    assert_response 200

  end
end
