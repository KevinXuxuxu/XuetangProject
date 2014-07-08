class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def currentSID
    if (session[:exp_time] > Time.now)
      return session[:sid]
    end
    return nil
  end

  def currentUser
    if (session[:exp_time] > Time.now)
      return User.find_by_stu_id(session[:sid])
    end
    return nil
  end

end
