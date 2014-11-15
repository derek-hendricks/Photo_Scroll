class LoginsController < ApplicationController

  def login
		username = params[:username]
		password = params[:password]
		author = Author.where("lower(username) = ?", username.downcase).first
		if author && author.authenticate(params[:password])
			session[:author_id] = author.id
			if author.admin 
				redirect_to authors_url 
			else
				redirect_to messages_url
			end
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
