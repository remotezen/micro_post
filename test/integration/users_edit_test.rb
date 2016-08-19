require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:fred)
  end

  test "unsuccessful edit" do
    #log_in_as(@user)
    get edit_user_path(@user)
    patch user_path(@user), params:{user:{name:"",
                                          username:"",
                                    email: "foo@invalid",
                                    password: "foo",
                                    password_confirmation: "bar"

                                    }}
    assert_template 'users/edit'
  end
  test "successful edit" do

    #options = {password: @user.password}
    #log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
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
end
