require 'test_helper'

class AuthorsSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get 'authors/new'
    assert_no_difference 'Author.count' do
      post authors_path, author: { full_name:  "",
                               username: "person",
                               profile: "some words in profile",
                               admin: false,
                               email: "user@invalid",
                               password:              "foo",
                               password_confirmation: "bar" }
    end
    assert_template 'authors/new'

  end
   test "valid signup information" do
    get 'authors/new'
    assert_difference 'Author.count', 1 do
      post authors_path, author: { full_name:  "john",
                               username: "person",
                               profile: "some words in profile",
                               admin: true,
                               email: "user@gmail.com",
                               password:              "password",
                               password_confirmation: "password" }
    end
    # assert_template "authors/show"
    # assert is_logged_in?
  end
   test "valid signup information with account activation" do
    get signup_path
    assert_difference 'Author.count', 1 do
      post authors_path, author: { full_name:  "Example Author",
                                 username:  "username1",
                                 profile: "hi some words",
                                 admin: false,
                                 email: "author@example.com",
                                 password:              "password",
                                 password_confirmation: "password" }
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    author = assigns(:bob)
    assert_not author.activated?
    # Try to log in before activation.
    log_in_as(author)
    assert_not is_logged_in?
    # Invalid activation token
    get edit_account_activation_path("invalid token")
    assert_not is_logged_in?
    # Valid token, wrong email
    get edit_account_activation_path(author.activation_token, email: 'wrong')
    assert_not is_logged_in?
    # Valid activation token
    get edit_account_activation_path(author.activation_token, email: author.email)
    assert author.reload.activated?
    follow_redirect!
    assert_template 'authors/show'
    assert is_logged_in?
  end
  
end

# bundle exec rake test TEST=test/integration/authors_signup_test.rb
