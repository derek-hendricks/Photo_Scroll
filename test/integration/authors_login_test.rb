require 'test_helper'

class AuthorsLoginTest < ActionDispatch::IntegrationTest
  
  def setup 
    @author = authors(:bob)
  end
  
  test "login with invalid information" do
    get "/login"
    assert_template 'logins/new'
    post login_path, login: { username: "", password: "" }
    assert_template 'logins/new'
    assert_not flash.empty?
     get "/signup"
    assert flash.empty?
  end
  
    test "login with valid information" do
    get login_path
    post login_path, login: { username: @author.username, password: 'password' }
    assert_redirected_to @author
    follow_redirect!
    assert_template 'authors/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", signup_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", author_path(@author)
  end
  
  
end

