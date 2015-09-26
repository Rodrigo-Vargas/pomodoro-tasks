class SessionsController < ApplicationController
  before_filter :save_login_state, :only => [:login, :login_attempt]

  def login
  end

  def login_attempt
    authorized_user = User.authenticate(params[:name_or_email],params[:login_password])
    
    if authorized_user
      session[:user_id] = authorized_user.id
      session[:user_name] = authorized_user.name
      redirect_to('/')
    else
      flash[:notice] = "Invalid Username or Password"
      flash[:color]= "invalid"
      render "login"  
    end
  end

  def logout
    session[:user_id] = nil
    session[:user_name] = nil
    redirect_to :action => 'login'
  end
end
