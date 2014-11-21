module ApplicationHelper

  def full_title(page_title = '')
    base_title = "Photo Scroll App"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end
  
  def current_user
   @current_user ||= User.find_by(id: cookies[:user_id]) if cookies[:user_id]
  end
  
  def current_user?(user)
    user == current_user
  end
  
end

