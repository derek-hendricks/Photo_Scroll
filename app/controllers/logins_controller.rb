class LoginsController < ApplicationController

  def login
	username = params[:username]
	password = params[:password]
	author = Author.where("lower(username) = ?", username.downcase).first
	if author != nil && (password.casecmp(author.password) == 0)
		session[:author_id] = author.id
		redirect_to messages_url
	else
		redirect_to login_url, :alert => "Unknown username/password"
	end
  end

  def logout
  	session[:author_id] = nil
  	redirect_to login_url, :alert => "Logged out"
  end

  def form 
  end


end
