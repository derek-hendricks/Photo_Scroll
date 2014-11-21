class AuthorsController < ApplicationController
  before_action :logged_in_author, only: [:index, :edit, :update, :destroy]
  before_action :correct_author,   only: [:edit, :update]
  before_action :admin_author,     only: :destroy
  
  def index
    @authors = Author.paginate(page: params[:page])
  end

  def show
    @author = Author.find(params[:id])
  end

  def new
    @author = Author.new
  end

  def edit
    @author = Author.find(params[:id])
  end

  def create
    @author = Author.new(author_params)
    if @author.save
      @author.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to login_url
     else
      render 'new'
    end
  end
  

  def update
    @author = Author.find(params[:id])
    if @author.update_attributes(author_params)
      flash[:success] = "Profile updated"
      redirect_to @author
    else
      render 'edit'
    end
  end

  def destroy
    Author.find(params[:id]).destroy
    flash[:success] = "Author deleted"
    redirect_to authors_url
  end

  def follow 
    author_id = session[:author_id]
    if author_id != nil 
      logged_in_author = Author.find(author_id)
      author = Author.find(params[:id])
      author.followers << logged_in_author unless author.followers.include? logged_in_author 
      redirect_to messages_url 
    else 
      redirect_to login_url, :alert => "You must login"
    end
  end

  private

    def author_params
      params.require(:author).permit(:full_name, :username, :password, :password_confirmation, :profile, :admin, :email)
    end
    
    def correct_author
      @author = Author.find(params[:id])
      redirect_to(root_url) unless current_author?(@author)
    end
    
    def admin_author
      redirect_to(root_url) unless current_author.admin?
    end
    
end
