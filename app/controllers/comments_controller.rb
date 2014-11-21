class CommentsController < ApplicationController
  before_action :logged_in_author, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  
  def new
    @comment = Comment.new
    @comments = Comment.order('created_at DESC')
    @main = true 
  end
 
  def create
    respond_to do |format|
      if current_user
        @comment = current_user.comments.build(comment_params)
        if @comment.save
          flash.now[:success] = 'Your comment was successfully posted!'
        else
          flash.now[:error] = 'Your comment cannot be saved.'
        end
        format.html {redirect_to new_comment_url}
        format.js
      else
        @feed_items = []
        format.html {redirect_to new_comment_url}
        format.js {render nothing: true}
      end
    end
  end
  
  def destroy
    @comment.destroy
    flash[:success] = "Comment deleted"
    redirect_to request.referrer || home_url
  end
  
  def vote
    comment = Comment.find(params[:id])
    current_user.votes << comment unless current_user.votes.include? comment
    redirect_to new_comment_url
  end
  
  private
 
    def comment_params
      params.require(:comment).permit(:body)
    end
    
    def correct_user
      @comment = current_user.comments.find_by(id: params[:id])
      redirect_to home_url if @comment.nil?
    end
    
end
