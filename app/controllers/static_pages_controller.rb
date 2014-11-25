class StaticPagesController < ApplicationController
  def home
    if logged_in? && current_user
      @comment  = current_user.comments.build
      @feed_items = current_user.feed
      @messages = @author.followed_messages.all
      @following = @author.follows.paginate(:page => params[:page], :per_page => 12)
    end
  end

  def help
  end

  def about
  end

  def contact
  end
   before_filter :login
   private 
    
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
