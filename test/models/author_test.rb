require 'test_helper'

class AuthorTest < ActiveSupport::TestCase

	def setup
		@user = authors(:basic_user)
		@derek = authors(:derek)
	end

	test "full name should be present" do
    @user.full_name = "     "
    assert_not @user.valid?
  end

  test "username should be present" do
    @user.username = "     "
    assert_not @user.valid?
  end

  test "password should be present" do
    @user.password = "     "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "full name should not be too long" do
    @user.full_name = "a" * 60
  	assert_not @user.valid?
  end
  
  test "password should not be too long" do
    @user.password = "a" * 20
  	assert_not @user.valid?
  end
  
  test "username should not be too long" do
    @user.username = "a" * 20
  	assert_not @user.valid?
  end

	test "user can follow derek" do
		@user.follows << @derek
		assert @user.follows.include?(@derek)
	end

	test "user can unfollow derek" do
		@user.follows << @derek
		@user.follows.delete(@derek)
		assert ! @user.follows.include?(@derek)
	end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

 test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

	test "email addresses should be unique" do
  	duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
  
end
