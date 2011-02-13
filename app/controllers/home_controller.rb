class HomeController < ApplicationController
  
  include Facebook
  before_filter :authenticate, 
    :except => [ :login, :connect, :get_token]
  
  def login
    render :login
  end

  def connect
    redirect_to Facebook.authorization_url
  end
  
  def get_token
    render :get_token
  end

end