require 'test_helper'

class AuthorsEditTest < ActionDispatch::IntegrationTest
 def setup
    @author = authors(:bob)
 end

  test "unsuccessful edit" do
    log_in_as(@author)
    get edit_author_path(@author)
    assert_template 'authors/edit'
    patch user_path(@author), author: { full_name:  "",
                                    email: "foo@invalid",
                                    username: "",
                                    profile: "",
                                    admin: false,
                                    password:              "foo",
                                    password_confirmation: "bar" }
    assert_template 'authors/edit'
  end
end
