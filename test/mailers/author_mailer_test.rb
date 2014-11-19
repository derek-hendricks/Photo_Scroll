require 'test_helper'

class AuthorMailerTest < ActionMailer::TestCase
  test "account_activation" do
    author = authors(:bob)
    author.activation_token = Author.new_token
    mail = AuthorMailer.account_activation(author)
    assert_equal "Account Activation", mail.subject
    assert_equal [author.email], mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match author.full_name, mail.body.encoded
    assert_match author.activation_token,   mail.body.encoded
    assert_match CGI::escape(author.email), mail.body.encoded
  end

  test "password_reset" do
    mail = AuthorMailer.password_reset
    assert_equal "Password reset", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
