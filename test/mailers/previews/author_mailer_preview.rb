# Preview all emails at http://localhost:3000/rails/mailers/author_mailer
class AuthorMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/author_mailer/account_activation
  def account_activation
    author = Author.first
    author.activation_token = Author.new_token
    AuthorMailer.account_activation(author)
  end

  # Preview this email at http://localhost:3000/rails/mailers/author_mailer/password_reset
  def password_reset
    AuthorMailer.password_reset
  end

end
