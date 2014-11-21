class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include LoginsHelper
  
  def current_user
   @current_user ||= User.find_by(id: cookies[:user_id]) if cookies[:user_id]
  end
  
  def current_user?(user)
    user == current_user
  end
 
  helper_method :current_user

  private 
    def logged_in_author
      unless logged_in?
        save_url
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
end
