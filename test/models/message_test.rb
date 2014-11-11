require 'test_helper'
class MessageTest < ActiveSupport::TestCase
	def setup 
		@user_admin = authors(:admin)
		@user = authors(:basic_user)
		@derek = authors(:derek)
		@msg = Message.new
		@msg.contents = "I have a cool idea for a new recipe!"
		@msg.author = @user 
	end
	test "an author can favourite a message" do 
		@derek.favourites << @msg
		assert_equal(1, @msg.favourites.size)
		assert_equal(@msg, @derek.favourites[0])
	end
	test "more than one author can favourite a message" do 
		@derek.favourites << @msg
    @user_admin.favourites << @msg
    assert_equal(2, @msg.favourites.size)
    assert @msg.favourites.include?(@user_admin)
    assert @msg.favourites.include?(@derek)
	end
end
