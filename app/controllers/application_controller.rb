class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def read_priv_level
    return 1
  end

  def edit_priv_level
    return 2
  end

  def create_priv_level
    return 3
  end

  def article_edit_priv_level
    return 3
  end

  def exp_time
    return 5 * 60
  end

  def currentSID
    if session[:exp_time] and session[:exp_time] > Time.now
      session[:exp_time] = Time.now + exp_time
      return session[:sid]
    end
    return nil
  end

  def currentUser
    if session[:exp_time] and session[:exp_time] > Time.now
      session[:exp_time] = Time.now + exp_time
      return User.find_by_stu_id(session[:sid])
    end
    return nil
  end

end
