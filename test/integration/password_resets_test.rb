require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest
  
  def setup
    ActionMailer::Base.deliveries.clear
    @author = authors(:bob)
  end

  test "password resets" do
    get new_password_reset_path
    assert_template 'password_resets/new'
    # Invalid email
    post password_resets_path, password_reset: { email: "" }
    assert_not flash.empty?
    assert_template 'password_resets/new'
    # Valid email
    post password_resets_path, password_reset: { email: @author.email }
    assert_not_equal @author.reset_digest, @author.reload.reset_digest
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    assert_redirected_to login_url
    # Password reset form
    author = assigns(:author)
    # Wrong email
    get edit_password_reset_path(author.reset_token, email: "")
    assert_redirected_to login_url
    # Inactive author
    author.toggle!(:activated)
    get edit_password_reset_path(author.reset_token, email: author.email)
    assert_redirected_to login_url
    author.toggle!(:activated)
    # Right email, wrong token
    get edit_password_reset_path('wrong token', email: author.email)
    assert_redirected_to login_url
    # Right email, right token
    get edit_password_reset_path(author.reset_token, email: author.email)
    assert_template 'password_resets/edit'
    # This makes sure that there is an input tag with the right name, (hidden) type, and email address
    assert_select "input[name=email][type=hidden][value=?]", author.email
    # Invalid password & confirmation
    patch password_reset_path(author.reset_token),
          email: author.email,
          author: { password: "joe", password_confirmation: "smith" }
    assert_select 'div#error_explanation'
    # Blank password & confirmation
    patch password_reset_path(author.reset_token), email: author.email, author: { password:"  ", password_confirmation: "  " }
    assert_not flash.empty?
    assert_template 'password_resets/edit'
    # Valid password & confirmation
    patch password_reset_path(author.reset_token), email: author.email, author: { password: "password", password_confirmation: "password" }
    assert is_logged_in?
    assert_not flash.empty?
    assert_redirected_to author
  end
end
