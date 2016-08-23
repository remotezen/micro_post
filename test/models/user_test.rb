require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar",
                    username: "example")
  end

  test "user should be valid" do
    assert @user.valid?
  end
  test "name should be present" do
    @user.name = " "
    assert_not @user.valid?
  end
  test "user name should be present" do
    @user.username = " "
    assert_not @user.valid?
  end
   test "assert email is present" do
     @user.email = " "
     assert_not @user.valid?
   end
    test "assert name is less then 51 characters" do
      @user.name = "a" * 51
      assert_not @user.valid?
    end
     test "assert username is less than 51 characters" do
       @user.username = "a" * 51
       assert_not @user.valid?
     end
     test "assert email is less than 256 characters in length" do
       @user.email = "a" * 256
       assert_not @user.valid?
     end

  test "user email is of a valid format" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                     first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |a|
      @user.email = a
      assert @user.valid?, "#{a.inspect} should be valid"
    end
  end

  test "user model rejects invalid email submissions" do
    invalid_addresses = %w[user@example,com
    user_at_foo.org user.name@example.
          foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |ia|
      @user.email = ia
      assert_not @user.valid?, "#{ia.inspect} should not be valid"
      end
    end
    test "email addresses should be unique" do
      duplicate_user = @user.dup
      @user.save
      assert_not duplicate_user.valid?
    end

    test "assert username is unique" do
      duplicate_user = @user.dup
      duplicate_user.email = "baz@bar.com"
      @user.save
      assert_not duplicate_user.valid?
    end

    test "assert username is not case sensitive" do
      duplicate_user = @user.dup
      duplicate_user.email = "baz@bar.com"
      duplicate_user.username = @user.username.upcase
      @user.save
      assert_not duplicate_user.valid?
    end

    test "assert is not case-sensitive" do
      duplicate_user = @user.dup
      duplicate_user.email = @user.email.upcase
      @user.save
      assert_not duplicate_user.valid?
    end

    test "password should be present (nonblank)" do
      @user.password = @user.password_confirmation = " " * 6
      assert_not @user.valid?
    end

    test "password should have a minimum length" do
      @user.password = @user.password_confirmation = "a" * 5
      assert_not @user.valid?
    end

    test "authenticated? should return false for a user with nil digest" do
      assert_not @user.authenticated?(:remember, "")
    end

    test "assoicated microposts should be destroyed" do
      @user.save
      @user.microposts.create!(content: "Ipsum Loqutor")
      assert_difference 'Micropost.count', -1 do
        @user.destroy
      end

    end

end
