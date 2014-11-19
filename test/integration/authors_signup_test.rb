require 'test_helper'

class AuthorsSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get 'authors/new'
    assert_no_difference 'Author.count' do
      post authors_path, author: { full_name:  "",
                               name: "",
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
                               name: "johnabc",
                               username: "person",
                               profile: "some words in profile",
                               admin: true,
                               email: "user@gmail.com",
                               password:              "password",
                               password_confirmation: "password" }
    end
    assert_template "authors/show"
    assert is_logged_in?
  end
end

# bundle exec rake test TEST=test/integration/users_login_test.rb
