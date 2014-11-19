class LoginsController < ApplicationController

	def new
	end

  def form 
  end

	def create 
		author = Author.find_by(username: params[:login][:username].downcase)
		if author && author.authenticate(params[:login][:password])
    	log_in author
    	params[:login][:remember_me] == '1' ? remember(author) : forget(author)
    	send_back_or author
    else
    	flash.now[:danger] = "wrong credentials"
			render 'new'
		end
	end
	
	def destroy 
		log_out if logged_in?
    redirect_to root_url
	end

end
