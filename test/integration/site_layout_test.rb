require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "layout links" do
    # get root_path
    get "/login"
	assert_response :success
   	post_via_redirect "/login", username: authors(:basic_user).username, password: authors(:basic_user).password
    get messages_path
    assert_select "a[href=?]", root_path, count: 1
    assert_select "a[href=?]", messages_path
    assert_select "a[href=?]", images_path
    assert_select "a[href=?]", login_path
  end
end
