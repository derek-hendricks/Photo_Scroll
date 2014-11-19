class AccountActivationsController < ApplicationController
  def edit
    author = Author.find_by(email: params[:email])
    if author && !author.activated? && author.authenticated?(:activation, params[:id])
      author.activate
      log_in author
      flash[:success] = "Account activated!"
      redirect_to author
    else
      flash[:danger] = "Invalid activation link"
      redirect_to login_url
    end
  end
end
