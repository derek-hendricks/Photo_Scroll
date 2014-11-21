class StaticPagesController < ApplicationController
  def home
    if logged_in? && current_user
      @comment  = current_user.comments.build
      @feed_items = current_user.feed
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
