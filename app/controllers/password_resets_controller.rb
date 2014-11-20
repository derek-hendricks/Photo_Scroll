class PasswordResetsController < ApplicationController
  before_action :get_author,   only: [:edit, :update]
  before_action :valid_author, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]
  def new
  end
   
  def create
    @author = Author.find_by(email: params[:password_reset][:email].downcase)
    if @author
      @author.create_reset_digest
      @author.send_password_reset_email
      flash[:info] = "Email sent with password reset instructions"
      redirect_to login_url
    else
      flash.now[:danger] = "Email address not found"
      render 'new'
    end
  end
  
  def update
    if both_passwords_blank?
      flash.now[:danger] = "Password/confirmation can't be blank"
      render 'edit'
    elsif @author.update_attributes(author_params)
      log_in @author
      flash[:success] = "Password has been reset."
      redirect_to @author
    else
      render 'edit'
    end
  end


  def edit
  end
  
  private 
  
    def author_params
      params.require(:author).permit(:password, :password_confirmation)
    end
  
    def both_passwords_blank?
      params[:author][:password].blank? &&
      params[:author][:password_confirmation].blank?
    end
  
    def get_author
      @author = Author.find_by(email: params[:email])
    end

    # Confirms valid author
    def valid_author
      unless (@author && @author.activated? && @author.authenticated?(:reset, params[:id]))
        redirect_to login_url
      end
    end
    
    def check_expiration
      if @author.password_reset_expired?
        flash[:danger] = "Password reset has expired."
        redirect_to new_password_reset_url
      end
    end
    
end
