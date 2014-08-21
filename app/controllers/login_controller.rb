class LoginController < ApplicationController

  def receive
    @sid = params[:sid]
    session[:sid] = @sid
    @time = session[:exp_time] = Time.now + exp_time

    if !User.find_by_stu_id(@sid)
      User.create :stu_id => @sid, :name => "first_login=" + Time.now.to_s
    end

    redirect_to "?sid=#{session[:sid]}&exp_time=" + @time.to_s.gsub(" ", "-")
  end

end

