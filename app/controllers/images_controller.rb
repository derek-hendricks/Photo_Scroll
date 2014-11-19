class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :edit, :update, :destroy]

  def index
    @images = Image.where(['flagged == ? or flagged is null', false])
  end

  def find 
    @images = Image.all.search_by_caption_and_description(params[:search]) if params[:search].present?
  end

  def fivestar 
    @images = Image.where(:rating => 80..100)
    respond_to do |format| 
      format.html 
      format.json { render :json => @images }
    end
  end

  def show
  end

  def new
    @image = Image.new
  end

  def edit
    @image = Image.find(params[:id])
  end

  def create
    @image = Image.new(image_params)
    @image.author = @author
    respond_to do |format|
      if @image.save
        format.html { redirect_to @image, notice: 'Image was successfully created.' }
        format.json { render :show, status: :created, location: @image }
      else
        format.html { render :new }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @image = Image.find(params[:id])
    respond_to do |format|
      if @image.update(image_params)
        format.html { redirect_to @image, notice: 'Image was successfully updated.' }
        format.json { render :show, status: :ok, location: @image }
      else
        format.html { render :edit }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @image.destroy
    respond_to do |format|
      format.html { redirect_to images_url, notice: 'Image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_image
      @image = Image.find(params[:id])
    end

    def image_params
      params.require(:image).permit(:caption, :description, :url, :rating, :flagged)
    end
   before_filter :login
   private
    def login
      author_id = session[:author_id]
      if author_id != nil 
        @author = Author.find(author_id)
      else 
        redirect_to login_url, :alert => "You must login"
      end
    end
end
