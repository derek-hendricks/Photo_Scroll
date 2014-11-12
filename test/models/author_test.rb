require 'test_helper'

class AuthorTest < ActiveSupport::TestCase

	def setup
		@user=authors(:basic_user)
		@derek=authors(:derek)
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
