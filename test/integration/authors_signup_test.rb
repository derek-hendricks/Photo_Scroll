require 'test_helper'

class AuthorsSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get 'authors/new'
    assert_no_difference 'Author.count' do
      post authors_path, author: { full_name:  "",
                               name: "",
                               username: "person",
                               profile: "some words in profile",
                               image: "image.com",
                               admin: false,
                               email: "user@invalid",
                               password:              "foo",
                               password_confirmation: "bar" }
    end
    assert_template 'authors/new'
    assert_select 'div#<CSS id for error explanation>'
    assert_select 'div.<CSS class for field with error>'
  end
   test "valid signup information" do
    get 'authors/new'
    assert_difference 'Author.count', 1 do
      post authors_path, author: { full_name:  "",
                               name: "derekabc",
                               username: "person",
                               profile: "some words in profile",
                               image: "image.com",
                               admin: true,
                               email: "user@gmail.com",
                               password:              "password",
                               password_confirmation: "password" }
    end
    assert_template 'authors/new'
    assert_not flash.FILL_IN
  end
end


