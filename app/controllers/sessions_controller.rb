class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(request.env['omniauth.auth'])
    cookies[:user_id] = user.id
    join_author_user
    flash[:success] = "Hello, #{user.name}!"
    redirect_to new_comment_path
  end
 
  def destroy
    cookies.delete(:user_id)
    flash[:success] = "See you!"
    redirect_to new_comment_path
  end
  
  def join_author_user
    current_user.authors_users << current_author unless current_user.authors_users.count >= 1
  end
   
  def auth_fail
    render text: "You've tried to authenticate via #{params[:strategy]}, but the following error occurred: #{params[:message]}", status: 500
  end

end
