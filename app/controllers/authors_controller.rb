class AuthorsController < ApplicationController
  before_action :set_author, only: [:show, :edit, :update, :destroy]

  def index
    @authors = Author.all
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
     log_in @author
        flash[:success] = "Thanks for signing up!"
        redirect_to @author
        # format.html { redirect_to @author, notice: 'Author was successfully created.' }
        # format.json { render :show, status: :created, location: @author }
      else
        render 'new'
      end
 
  end

  def update
    respond_to do |format|
      if @author.update(author_params)
        format.html { redirect_to @author, notice: 'Author was successfully updated.' }
        format.json { render :show, status: :ok, location: @author }
      else
        format.html { render :edit }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @author.destroy
    respond_to do |format|
      format.html { redirect_to authors_url, notice: 'Author was successfully destroyed.' }
      format.json { head :no_content }
    end
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
  # before_filter :login, :except => :follow
  # :except follow so login security won't be run when follow method is called
  # before_filter :login, :only => :index
  private
  
    def set_author
      @author = Author.find(params[:id])
    end

    def author_params
      params.require(:author).permit(:full_name, :username, :password, :password_confirmation, :profile, :image, :admin, :email)
    end

    def login
      author_id = session[:author_id]
      if author_id != nil
        @author = Author.find(author_id)
      else 
        redirect_to login_url, :alert => "you need to login"
      end
    end
end
