module LoginsHelper
  
  def log_in(author)
    session[:author_id] = author.id
  end
  
  def remember(author)
    author.remember
    cookies.permanent.signed[:author_id] = author.id
    cookies.permanent[:remember_token] = author.remember_token
  end
   
  def current_author?(author)
    author == current_author
  end
  
  def current_author
    if (author_id = session[:author_id])
      @current_author ||= Author.find_by(id: author_id)
    elsif (author_id = cookies.signed[:author_id])
      author = Author.find_by(id: author_id)
      if author && author.authenticated?(:remember, cookies[:remember_token])
        log_in author
        @current_author = author
      end
    end
  end
  
  def logged_in?
    !current_author.nil?
  end
  
  def forget(author)
    author.forget
    cookies.delete(:author_id)
    cookies.delete(:remember_token)
  end

  # Logs out the current author.
  def log_out
    forget(current_author)
    cookies.delete(:user_id)
    session.delete(:author_id)
    @current_author = nil
  end
  
  def send_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed.
  def save_url
    session[:forwarding_url] = request.url if request.get?
  end
  
end
