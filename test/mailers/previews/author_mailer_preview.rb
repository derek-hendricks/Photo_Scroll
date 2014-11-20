# Preview all emails at http://localhost:3000/rails/mailers/author_mailer
class AuthorMailerPreview < ActionMailer::Preview

  # https://rails-tutorial-derekhendricks.c9.io/rails/mailers/author_mailer/account_activation
  def account_activation
    author = Author.first
    author.activation_token = Author.new_token
    AuthorMailer.account_activation(author)
  end

  # https://rails-tutorial-derekhendricks.c9.io/rails/mailers/author_mailer/password_reset
  def password_reset
    author = Author.first
    author.reset_token = Author.new_token
    AuthorMailer.password_reset(author)
  end

end
