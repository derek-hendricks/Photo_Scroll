class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  respond_to :html, :json

  def index
    @title = "Latest messages"
    @messages = Message.all.paginate(:page => params[:page], :per_page => 3)
  end

  def streams
    if params[:stream] == 'favourites'
      @title = "Favourite messages"
      @messages = @author.favourites
    elsif params[:stream] == 'followed'
      @title = "Followed messages"
      @messages = @author.followed_messages
    end
      # convert @author.favourites into array by calling .all so paginate will work when displaying favourites
      @messages = @author.favourites.all.paginate(:page => params[:page], :per_page => 3)
      # render, otherwise looks for followed.html.erb
    render :action => :index
  end

  def show
    @message = Message.find(params[:id])
    respond_with @message
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

  def create
    @message = Message.new(message_params)
    @message.author = @author
    respond_to do |format|
      if @message.save
        format.html { redirect_to @message, notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
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
  
    def set_message
      @message = Message.find(params[:id])
    end

    def message_params
      params.require(:message).permit(:contents, :stream, :page)
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

