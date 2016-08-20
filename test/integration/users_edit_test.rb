require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:fred)
    @other = users(:one)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params:{user:{name:"",
                                          username:"",
                                    email: "foo@invalid",
                                    password: "foo",
                                    password_confirmation: "bar"

                                    }}
    assert_template 'users/edit'
  end
  test "successful edit" do

    log_in_as(@user)
    get edit_user_path(@user)
    name = "barney ruble"
    email = "foo@valid.com"
    patch user_path(@user), params:{user:{name:name,
                                          username: @user.username,
                                          email: @user.email,
                                          password: "",
                                          password_confirmation:""

                                    }}
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert @user.name, name
    assert @user.email, email
    assert_redirected_to @user
  end

  # test "the truth" do
  #   assert true
  # end
  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    username = "Foo bar".downcase
    email = "foo@bar.com"
    patch user_path(@user), params:{user:{username:username,
                                          email: email,
                                          password: "",
                                          password_confirmation:""

                                    }}
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal username, @user.username
    assert_equal email, @user.email
  end
  test "should not be able to update admin" do

    log_in_as(@other)
    assert_not @other.admin?
    patch user_path(@other), params:{user:{
                                          username: @other.username,
                                          password: "",
                                          password_confirmation:"",
                                          admin: true

                                    }}
    assert_not @other.reload.admin?
  end
end
