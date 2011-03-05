class HomeController < ApplicationController
  
  
  before_filter :authenticate, 
    :except => [ :login, :connect, :get_token, :expired, :access_denied]
  
  def login
    render :layout => "unauthorized"
  end

  def expired
    params[:notice] = "Your connection expired, login again"
    render :action => "login"
  end
  
  def access_denied
    params[:notice] = "You must do the login to access this page!"
    render :action => "login"
  end

  def connect
    redirect_to Facebook.authorization_url
  end
  
  def get_token
    render :layout => "thin"
  end

end