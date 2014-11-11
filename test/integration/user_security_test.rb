require 'test_helper'

class UserSecurityTest < ActionDispatch::IntegrationTest
	test "an author logs in and sees the messages page" do 
		get "/login"
		assert_response :success
   	post_via_redirect "/login", username: authors(:basic_user).username, password: authors(:basic_user).password
    assert_equal '/messages', path
	end
	test "an admin logs in and sees the authors page" do 
		get "/login"
		assert_response :success
		post_via_redirect "/login", username: authors(:admin).username, password: authors(:admin).password
		assert_equal '/authors', path
	end
	test "a basic user can't see the admin pages" do 
		get "/login"
		assert_response :success 
		post_via_redirect "/login", username: authors(:basic_user).username, password: authors(:basic_user).password
		assert_equal '/messages', path 
		get_via_redirect "/authors"
		assert_equal '/messages', path
	end
end
