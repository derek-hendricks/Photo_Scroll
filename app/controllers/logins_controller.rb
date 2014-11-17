class LoginsController < ApplicationController

  #def login
	#	username = params[:username]
	#	password = params[:password]
	#	author = Author.where("lower(username) = ?", username.downcase).first
	#	if author && author.authenticate(params[:password])
	#		session[:author_id] = author.id
	#		if author.admin 
	#			redirect_to authors_url 
	#		else
	#			redirect_to messages_url
	#		end
	#	else
	#		redirect_to login_url, :alert => "Unknown username/password"
	#	end
	#end
	
	def new
	end

  def form 
  end

	def create 
		author = Author.find_by(username: params[:login][:username].downcase)
		if author && author.authenticate(params[:login][:password])
    	log_in author
    	params[:login][:remember_me] == '1' ? remember(author) : forget(author)
    	redirect_to author
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
