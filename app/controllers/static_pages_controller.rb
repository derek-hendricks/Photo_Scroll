class StaticPagesController < ApplicationController
  
  def home
    if logged_in? && current_user
      @author = params[:username] ? Author.find_by(username: params[:username]) : @author 
      if @author
        @user = params[:username] ? Author.find_by(username: params[:username]).authors_users[0] : current_user 
        @comment  = @user.comments.build
        @feed_items = @user.feed
        @messages = @author.followed_messages.all
        @following = @author.follows.paginate(:page => params[:page], :per_page => 12)
      else 
      redirect_to home_url, :alert => "Sorry, but #{params[:username]} either doesn't exist or hasn't set up a home page yet"
      end
    end
  end
  

   before_filter :login
   
   private 

     def static_page_params
      params.require(:static_page).permit(:username)
    end
    
    def login 
     author_id = session[:author_id]
      if author_id != nil 
        if !user_logged_in?
          redirect_to new_comment_url, :alert => "In order to view home page, you need to connect to one of social networks below"
        end
        @author = Author.find(author_id)
      else 
        redirect_to login_url, :alert => "You must login"
      end
    end
end
