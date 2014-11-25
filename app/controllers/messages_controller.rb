class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  respond_to :html, :json
  
    def index
      @title = "Latest messages"
      @the_message = Message.new
      get_and_show_posts
    end

    def index_with_button
      get_and_show_posts
    end

  def streams
    if params[:stream] == 'favourites' || params[:author]
      @title = "Favourite messages"
      params[:author] ? author = Author.find(params[:author]) : author = @author
      @messages = author.favourites.all.paginate(:page => params[:page], :per_page => 3)
    elsif params[:stream] == 'followed'
      @title = "Followed messages"
      @messages = @author.followed_messages.all.paginate(:page => params[:page], :per_page => 3)
    end
    render :action => :index
  end

  def show
    @message = Message.find(params[:id])
  end

  def new
    @message = Message.new
  end

  def edit
  end

  def favourite
    message = Message.find(params[:id])
    @author.favourites << message unless @author.favourites.include? message
    redirect_to messages_url
  end
  
  def unfavourite 
    message = Message.find(params[:id])
    @author.favourites.delete(message) if @author.favourites.include? message
  end

  def create
    @the_message = Message.new(message_params)
    @the_message.author = @author
    respond_to do |format|
      if @the_message.save
        format.html { redirect_to messages_path }
        format.js { }
        
      else
        format.html { render :new }
        format.json { render json: @the_message.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  before_filter :login
  private
  
    def get_and_show_posts
      @messages = Message.paginate(page: params[:page], per_page: 8).order('created_at DESC')
      respond_to do |format|
        format.html
        format.js
      end
    end
  
    def set_message
      @message = Message.find(params[:id])
    end

     def message_params
       params.require(:message).permit(:contents, :stream, :picture, :author)
     end

    def login
      author_id = session[:author_id]
      if author_id != nil 
        @author = Author.find(author_id)
      else 
        redirect_to login_url, :alert => "You must login"
      end
    end
end

