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

end
